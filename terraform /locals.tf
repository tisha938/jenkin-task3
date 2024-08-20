locals {
  config = {
    dev = {
      vpc_name        = "jen_task3"
      vpc_cidr        = "10.1.0.0/24"
      public_subnets  = ["10.1.0.0/28", "10.1.0.16/28"]
      private_subnets = ["10.1.0.32/28"]
      azs             = ["ap-south-1a", "ap-south-1b"]

      alb_sg_name      = "jen_alb_sg"
      public_sg_name  = "jen_pub_sg"
      private_sg_name = "jen_priv_sg"
      alb_name         = "jen-alb"

      target_group_1_name   = "jen-tg1"
      target_group_2_name = "jen-tg2"
      certificate_1_arn     = "arn:aws:acm:ap-south-1:008971679473:certificate/a161add8-6442-43fe-8b18-b434cef371f1"

      public_instance_ami   = "ami-0ad21ae1d0696ad58"
      public_instance_type  = "t2.micro"
      private_instance_ami  = "ami-0ad21ae1d0696ad58"
      private_instance_type = "t2.medium"
    }
  }

  Environment = local.config.dev
}