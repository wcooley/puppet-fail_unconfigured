The 'fail_unconfigured' function was written to simplify a common pattern in
our manifests:

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

