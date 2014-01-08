
module Livecd
  VERSION = '1.0.1'
  VM_PREFIX = 'livecd-'

  def list_vms
    `vboxmanage list vms`.
       split("\n").
       # match each line to the regex we expect
       map{|x| /^"([^"]+)" {[^}]*}/.match(x)}.
       # remove nil's
       compact.
       # get the first match
       map{|x| x[1]}.
       # find all those that have the prefix
       find_all{|x| x.start_with? VM_PREFIX }.
       # remove the prefix
       map{|x| x.sub VM_PREFIX, '' }
  end

  def exists_vm?( name )
    list_vms.include? name
  end

  def get_vm_state( name )
    vboxinfo = `vboxmanage showvminfo --machinereadable livecd-webforpentester`
    state = vboxinfo.match(/VMState=\"([^\"]+)\"/)
    (state.nil?) ? nil : state[1]
  end

  def stop_vm( name )
    # if it exists:
    if exists_vm?(name)

      if get_vm_state(name) != 'PoweredOff'
        puts "stopping vm #{name}"
        `vboxmanage controlvm #{id(name)} poweroff`
      end

      for i in 1..4
        sleep 0.5
        state = get_vm_state name
        if state.nil?
          puts "Can't get state for vm '#{name}'. It may already be destroyed."
          break
        elsif state == 'poweroff'
          break
        end
      end

      puts "removing vm #{name}"
      `vboxmanage unregistervm #{id(name)} --delete`
    else
      $stderr.puts "Can't find vm '#{name}' to stop it."
    end
  end

  def stop_all_vms
    list_vms.each{|vm| stop_vm(vm)}
  end

  def run_iso( iso, opts )
    name = find_name_for iso
    puts "starting vm #{name} (#{iso})"
    start_vm id(name), iso, opts
  end

  private

  def start_vm( name_id, iso, opts )
    ram = (opts[:memory].nil?) ? '' : "--memory #{opts[:memory]}"
    # create the new vm
    `vboxmanage createvm --name #{name_id} --register`
    `vboxmanage modifyvm #{name_id} --ostype "Other" #{ram}`
    `vboxmanage storagectl #{name_id} --name "IDE Controller" --add ide --bootable on`
    `vboxmanage storageattach #{name_id} --storagectl "IDE Controller" --port 0 --device 1 --type dvddrive --medium "#{iso}"`
    `vboxmanage modifyvm #{name_id} --nic1 nat`
    `vboxmanage modifyvm #{name_id} --nic2 hostonly --hostonlyadapter2 vboxnet0`
    hl = (opts[:headless]) ? '--type headless' : ''
    `vboxmanage startvm #{name_id} #{hl}`
  end

  def find_name_for( iso )
    base = File::basename iso, '.iso'
    allowed_chars = /[a-z0-9_+-]+/i
    name = base.scan(allowed_chars).join('')

    vms = list_vms
    return name if not vms.include? name

    # so, name already exists, find an alternative
    # collect the existing digits we have already assigned first:
    digits = vms.
      # whatever fits our naming pattern
      find_all{|v| v.start_with? name}.
      # remove the prefix name
      map{|v| v.sub(name, '')}.
      # try to match the postfix to -[0-9]+ digits
      map{|v| v.match /^-([0-9]+)$/}.
      # remove all nonmatching
      compact.
      # get the digits
      map{|v| v[1].to_i}.sort

    # search for the first free digit
    i = 1
    while digits.include? i
      i += 1
    end
    "#{name}-#{i}"
  end

  def id(name)
    VM_PREFIX + name.to_s
  end
end
