pipeline{
  agent any
  
  
  parameters {
   choice(
       choices: ['apply' , 'destroy'],
       description: 'Perform action on infrastructure!',
       name: 'ACTION')
}
  stages {
   stage("Opening"){
         steps{
            //Welcome message
            script{
               sh "echo 'Welcome to Jenkins'"
}
}
}

   stage("Workspace_cleanup"){
        //Cleaning WorkSpace
        when {
        //only terraform apply if a "apply" is requested
        expression { params.ACTION == 'apply'}
}
        steps{
            step([$class: 'WsCleanup'])
}
}

   stage("Repo_clone"){
       //Clone repo from GitHub
      steps {
         checkout ([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[credentialsId: 'instance_id', url: 'git@github.com:shubh9975/ec2-instance1.git']]])

}
}
   stage("terraform_init"){
     //terraform init
     steps{
      script{
       sh "bash plugin.sh"
}
}
}

   stage("static_analysis"){
     //static analysis
      steps{
       script{
       sh '''
            cd file
            terraform validate
            cd -
       '''
}
}
}

   stage("terraform_plan"){
     //terraform plan
       when {
        //only terraform apply if a "apply" is requested
        expression { params.ACTION == 'apply'}
}
      steps{
       script{
       sh '''
            cd file
            terraform plan
            cd -
       '''
}
}
}


   stage("terraform_apply"){
    //terraform apply
     when {
        //only terraform apply if a "apply" is requested
        expression { params.ACTION == 'apply'}
}
     steps{
      script{
       sh '''
            cd file
            terraform apply --auto-approve
            cd -
       '''

}
}
}



   stage("terraform_destroy"){
    //terraform destroy
     when {
        //only terraform destroy if a "destroy" is requested
        expression { params.ACTION == 'destroy'}
} 
     steps{
      script{
       sh '''
            cd file
            terraform destroy --auto-approve
            cd -
       '''

}
}
}


   stage("Workspace_cleanup_destroy"){
        //Cleaning WorkSpace
        when { 
        //only terraform destroy if a "destroy" is requested
        expression { params.ACTION == 'destroy'}
}
        steps{
            step([$class: 'WsCleanup'])
}
}


}
}

