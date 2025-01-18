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

    env.SKIP_PROD = 'true'
    stage("Manual Approval") {
        try {
            input(message: 'Lanjutkan ke tahap Deploy?', ok: 'Yes')
            env.SKIP_PROD = 'false'
        } catch (Throwable e) {
            echo "Persetujuan diabaikan"
            Utils.markStageSkippedForConditional('Manual Approval')
        }
    }
    
    stage('Deploy') {
        if (env.SKIP_PROD == 'true') {
            echo "Lewati deploy"
            Utils.markStageSkippedForConditional('Deploy')
        } else {
            sh 'docker compose up -d'
            sh 'docker system prune -f &'
            sleep time: 1, unit: 'MINUTES'
            sh 'docker compose down -v'
        }
    }

}

