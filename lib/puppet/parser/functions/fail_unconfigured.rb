#   Copyright 2013 Wil Cooley <wcooley(at)nakedape.cc>
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

module Puppet::Parser::Functions
  newfunction(:fail_unconfigured, :doc => "Fail with a canned 'not_configured' message."
             ) do |args|

    args += ['operatingsystem', 'operatingsystemrelease', 'osfamily' ]
    args = ['node'] + args

    argpairs = [ "error=not_configured" ]
    argpairs << "module=#{self.source.module_name}" if self.source.module_name
    argpairs << "class=#{self.source.name}"         if self.source.name

    args.uniq.each do |arg|
        val = lookupvar(arg) || :undefined
        next if val == :undefined
        val = %Q{"#{val}"} if val =~ /[^\w\.]/
        argpairs.push("#{arg}=#{val}")
    end

    raise Puppet::ParseError, argpairs.join(" ")
  end
end
