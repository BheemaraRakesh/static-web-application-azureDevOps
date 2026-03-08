# Maven Concepts

## Overview
Apache Maven is a build automation and project management tool primarily used for Java projects. It uses a declarative XML-based configuration file (pom.xml) to manage project dependencies, build lifecycle, and plugins.

## Key Concepts

### 1. Project Object Model (POM)

#### pom.xml Structure
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    
    <name>My Application</name>
    <description>A sample Maven project</description>
    
    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
    </properties>
    
    <dependencies>
        <!-- Dependencies go here -->
    </dependencies>
    
    <build>
        <!-- Build configuration -->
    </build>
</project>
```

#### Coordinates
- **groupId:** Organization identifier
- **artifactId:** Project identifier
- **version:** Project version
- **packaging:** Package type (jar, war, pom, etc.)

### 2. Dependencies Management

#### Dependency Declaration
```xml
<dependencies>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.13.2</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

#### Dependency Scopes
- **compile:** Default scope, available in all classpaths
- **provided:** Provided by JDK or container
- **runtime:** Not needed for compilation but for execution
- **test:** Only for testing
- **system:** Explicit path to JAR

#### Transitive Dependencies
Maven automatically includes dependencies of dependencies.

### 3. Build Lifecycle

#### Default Lifecycle Phases
1. **validate:** Validate project structure
2. **compile:** Compile source code
3. **test:** Run unit tests
4. **package:** Package compiled code
5. **verify:** Run integration tests
6. **install:** Install package to local repository
7. **deploy:** Deploy package to remote repository

#### Common Commands
```bash
# Compile project
mvn compile

# Run tests
mvn test

# Package application
mvn package

# Install to local repository
mvn install

# Clean build artifacts
mvn clean

# Generate site documentation
mvn site
```

### 4. Plugins

#### Plugin Declaration
```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.1</version>
            <configuration>
                <source>11</source>
                <target>11</target>
            </configuration>
        </plugin>
    </plugins>
</build>
```

#### Common Plugins
- **maven-compiler-plugin:** Compile Java sources
- **maven-surefire-plugin:** Run unit tests
- **maven-failsafe-plugin:** Run integration tests
- **maven-jar-plugin:** Build JAR files
- **maven-war-plugin:** Build WAR files

### 5. Repositories

#### Local Repository
Default location: `~/.m2/repository`

#### Remote Repositories
- **Central Repository:** Maven's main repository
- **Private Repositories:** Nexus, Artifactory

#### Repository Configuration
```xml
<repositories>
    <repository>
        <id>central</id>
        <url>https://repo.maven.apache.org/maven2</url>
    </repository>
</repositories>
```

### 6. Profiles

#### Profile Definition
```xml
<profiles>
    <profile>
        <id>production</id>
        <properties>
            <db.url>prod-db.example.com</db.url>
        </properties>
    </profile>
</profiles>
```

#### Profile Activation
```bash
# Activate profile
mvn clean install -P production
```

### 7. Multi-Module Projects

#### Parent POM
```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>parent</artifactId>
    <version>1.0.0</version>
    <packaging>pom</packaging>
    
    <modules>
        <module>module1</module>
        <module>module2</module>
    </modules>
</project>
```

#### Module POM
```xml
<project>
    <parent>
        <groupId>com.example</groupId>
        <artifactId>parent</artifactId>
        <version>1.0.0</version>
    </parent>
    
    <artifactId>module1</artifactId>
</project>
```

### 8. Archetypes

#### Creating from Archetype
```bash
# Generate project from archetype
mvn archetype:generate -DgroupId=com.example -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
```

#### Custom Archetypes
Create reusable project templates.

## Real Project Examples

### Basic Java Application POM
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <groupId>com.example</groupId>
    <artifactId>java-app</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>jar</packaging>
    
    <name>Java Application</name>
    
    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
        
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>1.7.32</version>
        </dependency>
        
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>1.2.6</version>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>11</source>
                    <target>11</target>
                </configuration>
            </plugin>
            
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.0.0-M5</version>
            </plugin>
            
            <plugin>
                <groupId>org.codehaus.mojo</groupId>
                <artifactId>exec-maven-plugin</artifactId>
                <version>3.0.0</version>
                <configuration>
                    <mainClass>com.example.App</mainClass>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

### Spring Boot Application POM
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.6.3</version>
        <relativePath/>
    </parent>
    
    <groupId>com.example</groupId>
    <artifactId>spring-boot-app</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>jar</packaging>
    
    <properties>
        <java.version>11</java.version>
    </properties>
    
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
        
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

### Multi-Module Project Structure
```
parent-project/
├── pom.xml (parent POM)
├── module1/
│   ├── pom.xml
│   └── src/
├── module2/
│   ├── pom.xml
│   └── src/
└── module3/
    ├── pom.xml
    └── src/
```

## Best Practices
- Use semantic versioning
- Keep dependencies up to date
- Use dependency management for common versions
- Implement proper testing
- Use profiles for different environments
- Follow Maven conventions
- Use repositories for dependency management
- Implement CI/CD integration
- Document custom plugins and configurations
- Use archetypes for project templates