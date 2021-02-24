package("co")

    set_homepage("https://github.com/idealvin/co")
    set_description("Yet another libco and more.")

    add_urls("https://github.com/idealvin/co.git")

    on_load("windows", function (package)
        assert(package:config("vs_runtime"):sub(1, 2) == "MD",
            "co is built with MD runtime, cannot use MT")
    end)

    if is_plat("linux") then
        add_syslinks("pthread", "dl")
    end

    on_install("macosx", "linux", "windows", function (package)
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            #include "co/def.h"
            #include "co/atomic.h"
            void test() {
                int32 i32 = 0;
                atomic_inc(&i32);
            }
        ]]}, {configs = {languages = "c++11"}}))
    end)
