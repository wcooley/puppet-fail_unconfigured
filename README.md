[![Build Status](https://travis-ci.org/wcooley/puppet-fail_unconfigured.png?branch=master)](https://travis-ci.org/wcooley/puppet-fail_unconfigured)

fail_unconfigured
=================

Description
-----------

The 'fail_unconfigured' function was written to simplify a common default case: fail and log a few facts that are often used in case expressions.

    class foo::params {
        case $operatingsystem {
            "knownos": { ... }
            default: {
                fail("error=not_configured node=$hostname module=foo operatingsystem=$operatingsystem")
            }
        }
    }

With this function, we are able to simplify to this:

    class foo::params {
        case $operatingsystem {
            "knownos": { ... }
            default: { fail_unconfigured() }
        }
    }

Author
-------
Wil Cooley wcooley(at)nakedape.cc

License
-------

    Author:: Wil Cooley (wcooley(at)nakedape.cc)
    Copyright:: Copyright (c) 2013 Wil Cooley
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


Support
-------

Please log tickets and issues at our [Github project](https://github.com/wcooley/puppet-fail_unconfigured/issues).
