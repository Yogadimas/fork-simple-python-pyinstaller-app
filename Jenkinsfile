node {
     checkout scm
    def dockerImage


    stage('Build') {
        dockerImage = docker.build("my-python-app", ".")
    }

    stage('Tests') {
        dockerImage.inside {
            sh 'pytest --verbose --junit-xml test-reports/results.xml sources/test_calc.py'
            junit 'test-reports/results.xml'
        }
    }

}

