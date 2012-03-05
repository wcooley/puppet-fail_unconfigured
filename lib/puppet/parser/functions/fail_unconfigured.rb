module Puppet::Parser::Functions
  newfunction(:fail_unconfigured, :doc => "Fail with a canned 'not_configured' message."
             ) do |args|
    node = lookupvar('hostname')
    modulename = self.source.module_name || 'unknown'
    puppet_class = self.source.name || 'unknown'

    if args.length == 0
        args = ['operatingsystem', 'operatingsystemrelease', 'osfamily' ]
    end

    argpairs = [
        "error=not_configured",
        "node=#{node}",
        "module=#{modulename}",
        "class=#{puppet_class}"
    ]

    args.each do |arg|
        val = lookupvar(arg).downcase || 'unknown'
        argpairs.push("#{arg}=#{val}")
    end

    raise Puppet::ParseError, argpairs.join(" ")
  end
end
