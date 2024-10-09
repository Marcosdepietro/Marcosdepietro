pipeline {
    agent {label 'ansible-controller'}
    stages {
        stage('Execute ansible playbook') {
            steps {
                sh '''
                ansible-playbook -i project/inventory.ini project/playbooks/site.yml
                '''
                }
        }
    }
}