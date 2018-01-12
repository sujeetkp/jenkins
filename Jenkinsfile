pipeline {
    
    agent any
    
    stages {
        stage('Build') {
            steps { 
               sh 'echo Build'
               sh 'hostname'
               readFile('Dockerfile')
            }
        }
        stage('Test'){
            steps {
                sh 'echo Test'
                sh 'hostname'
            }
        }
        stage('Deploy') {
            steps {
               sh 'echo Deploy'
               sh 'hostname'
            }
        }
    }
}
