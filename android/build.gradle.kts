allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

ndk {
        // Set your desired NDK version (e.g., "25.1.9517409")
        // or rely on the one installed in SDK Manager for simplicity
        ndkVersion "28.2.13676358"
    }
    
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
