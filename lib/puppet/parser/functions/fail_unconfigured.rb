module Puppet::Parser::Functions
  newfunction(:fail_unconfigured, :doc => "Fail with a canned 'not_configured' message."
             ) do |args|

    if args.length == 0
        args = ['operatingsystem', 'operatingsystemrelease', 'osfamily' ]
    end
    args = ['node'] + args

    argpairs = [ "error=not_configured" ]
    argpairs << "module=#{self.source.module_name}" if self.source.module_name
    argpairs << "class=#{self.source.name}"         if self.source.name

    args.each do |arg|
        val = lookupvar(arg) || :undefined
        next if val == :undefined
        val.downcase!
        val = %Q{"#{val}"} if val =~ /[^\w\.]/
        argpairs.push("#{arg}=#{val}")
    end

    raise Puppet::ParseError, argpairs.join(" ")
  end
end
