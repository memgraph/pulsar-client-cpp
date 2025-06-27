from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout, CMakeDeps
from conan.tools.env import VirtualBuildEnv, Environment
from conan.tools.build import check_min_cppstd, check_max_cppstd
from conan.tools.files import get
import os


class PulsarClientCppConan(ConanFile):
    name = "pulsar-client-cpp"
    version = "2.8.1"
    license = "Apache-2.0"
    url = "https://github.com/apache/pulsar-client-cpp"
    description = "Apache Pulsar C++ client library"
    topics = ("apache", "pulsar", "pub-sub", "messaging", "cpp")
    settings = "os", "compiler", "build_type", "arch"
    options = {
        "shared": [True, False],
        "asio": [True, False],
        "with_ssl": [True, False],
        "with_tests": [True, False],
        "with_python": [True, False],
        "with_perf_tools": [True, False],
    }
    default_options = {
        "asio": False,
        "shared": False,
        "with_ssl": True,
        "with_tests": True,
        "with_python": False,
        "with_perf_tools": False,
    }

    # Build-time tools: e.g. cmake, ninja, protoc, clang-format, doxy
    tool_requires = ["protobuf/3.12.4"]

    def source(self):
        get(self, "https://github.com/apache/pulsar/archive/refs/tags/v2.8.1.tar.gz")


   
    def requirements(self):
        self.requires("protobuf/3.12.4", options={"lite": True})
        self.requires("abseil/20240116.2")
        self.requires("boost/1.86.0")
        self.requires("libcurl/8.12.1")
        self.requires("zlib/1.3.1")
        self.requires("openssl/3.5.0")
        self.requires("zstd/1.5.7")
        self.requires("snappy/1.2.1")
        self.requires("gtest/1.12.1")

    def validate(self):
        check_min_cppstd(self, "11")
        check_max_cppstd(self, "26")

    def layout(self):
        cmake_layout(self)

    def generate(self):
        tc = CMakeToolchain(self)
        tc.variables["CMAKE_CXX_STANDARD"] = "20"
        tc.variables["CMAKE_CXX_STANDARD_REQUIRED"] = True
        tc.variables["CMAKE_CXX_EXTENSIONS"] = False
        tc.variables["BUILD_PYTHON_WRAPPER"] = False
        tc.generate()

        # We don't need that because of generators
        deps = CMakeDeps(self)
        deps.generate()


    def build(self):
        env = Environment()
        for dep in self.dependencies.values():
             for p in dep.cpp_info.includedirs:
                 env.prepend_path("CPLUS_INCLUDE_PATH", p)
             for p in dep.cpp_info.libdirs:
                 env.prepend_path("LD_LIBRARY_PATH", p)
                 env.prepend_path("LIBRARY_PATH", p)

        # Add build output lib directory to library paths
        build_lib_dir = os.path.join(self.build_folder, "lib")
        os.makedirs(build_lib_dir, exist_ok=True)
        env.prepend_path("LIBRARY_PATH", build_lib_dir)
        env.prepend_path("LD_LIBRARY_PATH", build_lib_dir)
        with env.vars(self).apply():
            cmake = CMake(self)
            cmake.configure(build_script_folder="pulsar-2.8.1/pulsar-client-cpp")
            cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.configure(build_script_folder="pulsar-2.8.1/pulsar-client-cpp")
        cmake.install()


    def package_info(self):
        self.cpp_info.libs = ["pulsar"]
