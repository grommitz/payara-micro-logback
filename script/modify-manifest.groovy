def payaraMicroRootPath = new File('.').toPath().resolve('target/payara-micro')
def manifest = payaraMicroRootPath.resolve('META-INF/MANIFEST.MF').toFile()

// extract manifest content
def manifestContents = []
manifest.eachLine { line ->
    manifestContents << line
}

// remove the misleading content from manifest
manifestContents = manifestContents.findAll { !it.startsWith('Ant-Version') }

// remove empty line
manifestContents = manifestContents.findAll { !it.trim().isEmpty() }

// append the Class-Path
def classPathDependencies = payaraMicroRootPath.resolve('libs').toFile().list().collect { "libs/$it" }.join(' ')
manifestContents << 'Class-Path: ' + classPathDependencies

def writer = new PrintWriter(manifest)
manifestContents.each { line -> writer.println(line) }
writer.close()