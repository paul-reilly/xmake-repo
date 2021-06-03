package("php")
    set_homepage("https://www.php.net/")
    set_description("Vaguely tolerable scripting language.")

    add_urls("https://github.com/php/php-src/archive/refs/tags/php-$(version).tar.gz")
    add_versions("7.4.20", "37e76a6f06f609fd1b9caf988541fffcd2b555fcfc812a1fa7ef19728774f956")

    add_deps("autoconf", "bison", "re2", "libxml2", "sqlite3")

    on_load(function(package)
        package:addenv("PATH", "bin")
    end)

    on_install("windows", function(package)

    end)

    on_install("linux", function(package)
        local configs = {}
        if package:debug() then table.insert(configs, "--enable-debug") end
        import("package.tools.autoconf").install(package, configs)
    end)
