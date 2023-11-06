node {
   def registryProjet='registry.gitlab.com/jenkins5753330/wordpress'
   def IMAGE="${registryProjet}:version-${env.BUILD_ID}"
    stage('Build - Clone') {
          git 'https://github.com/Ismabayili/wordpress'
    }
    stage('Build - Maven package'){
            sh 'mvn package'
    }
    def img = stage('Build') {
          docker.build("$IMAGE",  '.')
    }
    stage('Build - Test') {
            img.withRun("--name run-$BUILD_ID -p 81:80") { c ->
            sh 'docker ps'
            sh 'netstat -ntaup'
            sh 'sleep 30s'
            sh 'curl 127.0.0.1:81'
            sh 'docker ps'
          }
    }
    stage('Build - Push') {
          docker.withRegistry('https://registry.gitlab.com/jenkins5753330/wordpress', 'reg1') {
              img.push 'latest'
              img.push()
          }
    }
    stage('Deploy - End') {
      ansiblePlaybook (
          colorized: true,
          become: true,
          playbook: 'playbook.yml',
          inventory: '${HOST},',
          extras: "--user=jenkins --extra-vars 'image=${IMAGE} ansible_sudo_pass=Isma@2023'"
      )
    }
}
