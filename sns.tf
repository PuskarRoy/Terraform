module "my_sns_topic" {
  source     = "./module/sns"
  topic_name = "my-sns-topic"
}