script_folder="/home/andi.linux/Memgraph/pulsar_build/test_package/build/gcc-13-armv8-gnu20-release/generators"
echo "echo Restoring environment" > "$script_folder/deactivate_conanrunenv-release-armv8.sh"
for v in OPENSSL_MODULES
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/deactivate_conanrunenv-release-armv8.sh"
    else
        echo unset $v >> "$script_folder/deactivate_conanrunenv-release-armv8.sh"
    fi
done


export OPENSSL_MODULES="/home/andi.linux/.conan2/p/b/opens3cf2b0bff6958/p/lib/ossl-modules"