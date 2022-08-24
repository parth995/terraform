         ___        ______     ____ _                 _  ___  
        / \ \      / / ___|   / ___| | ___  _   _  __| |/ _ \ 
       / _ \ \ /\ / /\___ \  | |   | |/ _ \| | | |/ _` | (_) |
      / ___ \ V  V /  ___) | | |___| | (_) | |_| | (_| |\__, |
     /_/   \_\_/\_/  |____/   \____|_|\___/ \__,_|\__,_|  /_/ 
 ----------------------------------------------------------------- 


Hi there! Welcome to AWS Cloud9!

To get started, create some files, play with the terminal,
or visit https://docs.aws.amazon.com/console/cloud9/ for our documentation.

Happy coding!

$$$$$$$$$$$ TERRAFORM COMMANDS $$$$$$$$$$$$$$$$$$$$$

#terraform fmt -diff - shows diff that are made
#terraform plan
#terraform apply
#terraform destroy 
#terraform plan -out=plan1 -> creates plan1 file encoded
#terraform apply plan1 -> plan is great for automation bypassing yes confirmation
#terraform plan -destroy -> shows what resources will be deleted

#terraform-state = state of resources that we deployed
#serial count is updated every time resource is updated. state with higher count is used when performing tf operations
#lineage is created during first time. every time during deployment this is checked and matched.

#terraform destroy --auto-approve -> removes resource without confirmation. This operation changes terraform.tfstate file content and serial number increases. tfstate.backup stores previous state
#terraform show -json | jq -> show current state
#terraform apply --auto-approve -> deploy this to change state
#terraform show -json | jq -> show changed state content that's stored in tfstate file.
#terraform state list -> shows all resources in current list
#terraform console -> access variables defined in construct



#terraform join function :-
      # join(seperator, list)
      # > join(";", ["thing", 1])
      # "thing;1"
      # > join(";", ["thing ", 1])
      # "thing ;1"
      # > join ("-", ["this", "sentence", "has", 2 + 2, "dashes"])
      # "this-sentence-has-4-dashes"
      # > 2 + 2
      # 4
      # > docker_container.nodered_container.ports
      # tolist([
      #   {
      #     "external" = 1880
      #     "internal" = 1880
      #     "ip" = "0.0.0.0"
      #     "protocol" = "tcp"
      #   },
      # ])
      # > docker_container.nodered_container.ports[0].external
      # 1880
      # > docker_container.nodered_container.ip_address
      # "172.17.0.2"
      # > join(":", [docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
      # "172.17.0.2:1880"
      


# splat operator
# > docker_container.nodered_container[*].name
# [
#   "nodered-lrnc",
#   "nodered-ev5i",
# ]

#for loop
# > [for i in [1,2,3]: i + 1]
# [
#   2,
#   3,
#   4,
# ]
# > [for i in docker_container.nodered_container[*]: i.name]
# [
#   "nodered-lrnc",
#   "nodered-ev5i",
# ]
# > [for i in docker_container.nodered_container[*]: i.ports[0]["external"]]
# [
#   49155,
#   49156,
# ]
# > [for i in docker_container.nodered_container[*]: i.ports[*]["external"]]
# [
#   tolist([
#     49155,
#   ]),
#   tolist([
#     49156,
#   ]),
# ]



#tainting -> force to delete and re-apply configuration