def payaraMicroRootPath = new File('.').toPath().resolve('target/payara-micro')
def manifest = payaraMicroRootPath.resolve('META-INF/MANIFEST.MF').toFile()

// extract manifest content
def manifestContents = []
manifest.eachLine {
    manifestContents << it
}

// remove the misleading content from manifest
manifestContents = manifestContents.findAll { !it.startsWith('Ant-Version') }

// remove empty line
manifestContents = manifestContents.findAll { !it.trim().isEmpty() }

// append the Class-Path
def classPathDependencies = payaraMicroRootPath.resolve('libs').toFile().list().collect { "libs/$it" }.join(' ')
manifestContents << 'Class-Path: ' + classPathDependencies

manifest.withWriter('utf-8') {
    it.println(manifestContents.join('\n'))
}
