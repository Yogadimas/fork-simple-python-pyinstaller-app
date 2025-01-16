node {
    def dockerImage

    stage('Prepare Docker Environment') {
        dockerImage = docker.image('python:3.12-slim')
        dockerImage.run('-p 5000:5000')
    }

    stage('Build') {
        dockerImage.inside {
            sh 'pip install -r requirements.txt'
            sh 'python -m py_compile sources/add2vals.py sources/calc.py'
        }
    }

    stage('Test') {
        dockerImage.inside {
            sh 'pytest --verbose --junit-xml test-reports/results.xml sources/test_calc.py'
            junit 'test-reports/results.xml'
        }
    }

}
