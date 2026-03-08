# Jenkins Concepts

## Overview
Jenkins is an open-source automation server that enables CI/CD pipelines. It allows building, testing, and deploying software automatically.

## Key Concepts

### 1. Jenkins Architecture

#### Master-Slave Architecture
- **Master:** Central server managing jobs and slaves
- **Slaves/Agents:** Worker nodes executing jobs

#### Controller-Agent Model (Jenkins 2.x+)
- **Controller:** Manages configuration and jobs
- **Agents:** Execute jobs

### 2. Job Types

#### Freestyle Projects
Simple jobs with basic configuration.

#### Pipeline Jobs
Complex workflows defined in code (Jenkinsfile).

#### Multi-configuration Projects
Matrix builds for different configurations.

#### Folders
Organize jobs hierarchically.

### 3. Pipeline as Code

#### Declarative Pipeline
Structured, opinionated syntax.

**Example:**
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
    }
}
```

#### Scripted Pipeline
Flexible, Groovy-based syntax.

**Example:**
```groovy
node {
    stage('Build') {
        echo 'Building...'
    }
    stage('Test') {
        echo 'Testing...'
    }
}
```

### 4. Agents and Nodes

#### Agent Types
- **Permanent Agents:** Always connected
- **Cloud Agents:** Dynamically provisioned
- **SSH Agents:** Connected via SSH

#### Labels
Tag agents for job targeting.

### 5. Plugins

#### Essential Plugins
- Git Plugin
- Pipeline Plugin
- Docker Plugin
- Kubernetes Plugin
- Blue Ocean (UI improvement)

#### Plugin Management
- Install via UI
- Update regularly
- Security considerations

### 6. Credentials Management

#### Credential Types
- Username/Password
- SSH Keys
- API Tokens
- Certificates

#### Storage
- Jenkins credential store
- External systems (HashiCorp Vault)

### 7. Build Triggers

#### Manual Triggers
- Build Now button

#### Automated Triggers
- Poll SCM
- Webhooks
- Scheduled builds
- Upstream/downstream triggers

### 8. Parameters

#### Parameter Types
- String
- Boolean
- Choice
- File
- Password

**Example:**
```groovy
parameters {
    string(name: 'BRANCH', defaultValue: 'main', description: 'Branch to build')
    choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'], description: 'Target environment')
}
```

### 9. Distributed Builds

#### Load Balancing
- Distribute jobs across agents
- Node restrictions
- Label-based assignment

#### Agent Provisioning
- Docker agents
- Kubernetes agents
- Cloud agents (AWS, Azure)

### 10. Security

#### Authentication
- Jenkins users
- LDAP/AD integration
- SSO integration

#### Authorization
- Matrix-based security
- Role-based access control
- Project-based matrix

#### Best Practices
- Regular updates
- Plugin security
- Network isolation
- Credential rotation

## Real Project Examples

### Basic CI Pipeline
```groovy
pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'myapp'
        DOCKER_TAG = "${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/myorg/myapp.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('Package') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }
        
        stage('Deploy to Dev') {
            when {
                branch 'develop'
            }
            steps {
                sh "docker run -d -p 8080:8080 ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
        always {
            cleanWs()
        }
    }
}
```

### Multi-Branch Pipeline
```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        echo 'Building main branch'
                        // Production build steps
                    } else if (env.BRANCH_NAME.startsWith('feature/')) {
                        echo 'Building feature branch'
                        // Feature build steps
                    } else {
                        echo 'Building other branch'
                        // Default build steps
                    }
                }
            }
        }
    }
}
```

### Docker-based Agent Pipeline
```groovy
pipeline {
    agent {
        docker {
            image 'maven:3.8.4-openjdk-11'
            args '-v /tmp:/tmp'
        }
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}
```

### Kubernetes Agent Pipeline
```groovy
pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: maven
    image: maven:3.8.4-openjdk-11
    command:
    - cat
    tty: true
  - name: docker
    image: docker:latest
    command:
    - cat
    tty: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
  volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock
'''
        }
    }
    
    stages {
        stage('Build') {
            steps {
                container('maven') {
                    sh 'mvn clean package'
                }
            }
        }
        
        stage('Build Image') {
            steps {
                container('docker') {
                    sh 'docker build -t myapp .'
                }
            }
        }
    }
}
```

## Best Practices
- Use Pipeline as Code
- Implement proper error handling
- Use shared libraries for reusable code
- Implement security scanning
- Use agents for isolation
- Monitor pipeline performance
- Implement proper logging
- Use parameters for flexibility
- Implement approval gates for production
- Regularly backup Jenkins configuration