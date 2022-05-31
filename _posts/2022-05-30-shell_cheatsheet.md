---
title: "Super Cheatsheet"
categories: [linux, shell]
tags: [window-manager, tmux, shell, cheatsheet]
---

# SUPER CS

## tmux

| Alias  | Command                | Description                                              |
| ------ | ---------------------- | -------------------------------------------------------- |
| `ta`   | tmux attach -t         | Attach new tmux session to already running named session |
| `tad`  | tmux attach -d -t      | Detach named tmux session                                |
| `ts`   | tmux new-session -s    | Create a new named tmux session                          |
| `tl`   | tmux list-sessions     | Displays a list of running tmux sessions                 |
| `tksv` | tmux kill-server       | Terminate all running tmux sessions                      |
| `tkss` | tmux kill-session -t   | Terminate named running tmux session                     |
| `tmux` | `_zsh_tmux_plugin_run` | Start a new tmux session                                 |

# docker

```
# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }
```

## docker-compose

| Alias     | Command                     | Description                                                      |
| --------- | --------------------------- | ---------------------------------------------------------------- |
| dco       | `docker-compose`            | Docker-compose main command                                      |
| dcb       | `docker-compose build`      | Build containers                                                 |
| dce       | `docker-compose exec`       | Execute command inside a container                               |
| dcps      | `docker-compose ps`         | List containers                                                  |
| dcrestart | `docker-compose restart`    | Restart container                                                |
| dcrm      | `docker-compose rm`         | Remove container                                                 |
| dcr       | `docker-compose run`        | Run a command in container                                       |
| dcstop    | `docker-compose stop`       | Stop a container                                                 |
| dcup      | `docker-compose up`         | Build, (re)create, start, and attach to containers for a service |
| dcupb     | `docker-compose up --build` | Same as `dcup`, but build images before starting containers      |
| dcupd     | `docker-compose up -d`      | Same as `dcup`, but starts as daemon                             |
| dcdn      | `docker-compose down`       | Stop and remove containers                                       |
| dcl       | `docker-compose logs`       | Show logs of container                                           |
| dclf      | `docker-compose logs -f`    | Show logs and follow output                                      |
| dcpull    | `docker-compose pull`       | Pull image of a service                                          |
| dcstart   | `docker-compose start`      | Start a container                                                |
| dck       | `docker-compose kill`       | Kills containers                                                 |

## kubectl

| Alias    | Command                               | Description                                                                                      |
| :------- | :------------------------------------ | :----------------------------------------------------------------------------------------------- |
| k        | `kubectl`                             | The kubectl command                                                                              |
| kca      | `kubectl --all-namespaces`            | The kubectl command targeting all namespaces                                                     |
| kaf      | `kubectl apply -f`                    | Apply a YML file                                                                                 |
| keti     | `kubectl exec -ti`                    | Drop into an interactive terminal on a container                                                 |
|          |                                       | **Manage configuration quickly to switch contexts between local, dev and staging**               |
| kcuc     | `kubectl config use-context`          | Set the current-context in a kubeconfig file                                                     |
| kcsc     | `kubectl config set-context`          | Set a context entry in kubeconfig                                                                |
| kcdc     | `kubectl config delete-context`       | Delete the specified context from the kubeconfig                                                 |
| kccc     | `kubectl config current-context`      | Display the current-context                                                                      |
| kcgc     | `kubectl config get-contexts`         | List of contexts available                                                                       |
|          |                                       | **General aliases**                                                                              |
| kdel     | `kubectl delete`                      | Delete resources by filenames, stdin, resources and names, or by resources and label selector    |
| kdelf    | `kubectl delete -f`                   | Delete a pod using the type and name specified in -f argument                                    |
|          |                                       | **Pod management**                                                                               |
| kgp      | `kubectl get pods`                    | List all pods in ps output format                                                                |
| kgpw     | `kgp --watch`                         | After listing/getting the requested object, watch for changes                                    |
| kgpwide  | `kgp -o wide`                         | Output in plain-text format with any additional information. For pods, the node name is included |
| kep      | `kubectl edit pods`                   | Edit pods from the default editor                                                                |
| kdp      | `kubectl describe pods`               | Describe all pods                                                                                |
| kdelp    | `kubectl delete pods`                 | Delete all pods matching passed arguments                                                        |
| kgpl     | `kgp -l`                              | Get pods by label. Example: `kgpl "app=myapp" -n myns`                                           |
| kgpn     | `kgp -n`                              | Get pods by namespace. Example: `kgpn kube-system`                                               |
|          |                                       | **Service management**                                                                           |
| kgs      | `kubectl get svc`                     | List all services in ps output format                                                            |
| kgsw     | `kgs --watch`                         | After listing all services, watch for changes                                                    |
| kgswide  | `kgs -o wide`                         | After listing all services, output in plain-text format with any additional information          |
| kes      | `kubectl edit svc`                    | Edit services(svc) from the default editor                                                       |
| kds      | `kubectl describe svc`                | Describe all services in detail                                                                  |
| kdels    | `kubectl delete svc`                  | Delete all services matching passed argument                                                     |
|          |                                       | **Ingress management**                                                                           |
| kgi      | `kubectl get ingress`                 | List ingress resources in ps output format                                                       |
| kei      | `kubectl edit ingress`                | Edit ingress resource from the default editor                                                    |
| kdi      | `kubectl describe ingress`            | Describe ingress resource in detail                                                              |
| kdeli    | `kubectl delete ingress`              | Delete ingress resources matching passed argument                                                |
|          |                                       | **Namespace management**                                                                         |
| kgns     | `kubectl get namespaces`              | List the current namespaces in a cluster                                                         |
| kcn      | `kubectl config set-context ...`      | Change current namespace                                                                         |
| kens     | `kubectl edit namespace`              | Edit namespace resource from the default editor                                                  |
| kdns     | `kubectl describe namespace`          | Describe namespace resource in detail                                                            |
| kdelns   | `kubectl delete namespace`            | Delete the namespace. WARNING! This deletes everything in the namespace                          |
|          |                                       | **ConfigMap management**                                                                         |
| kgcm     | `kubectl get configmaps`              | List the configmaps in ps output format                                                          |
| kecm     | `kubectl edit configmap`              | Edit configmap resource from the default editor                                                  |
| kdcm     | `kubectl describe configmap`          | Describe configmap resource in detail                                                            |
| kdelcm   | `kubectl delete configmap`            | Delete the configmap                                                                             |
|          |                                       | **Secret management**                                                                            |
| kgsec    | `kubectl get secret`                  | Get secret for decoding                                                                          |
| kdsec    | `kubectl describe secret`             | Describe secret resource in detail                                                               |
| kdelsec  | `kubectl delete secret`               | Delete the secret                                                                                |
|          |                                       | **Deployment management**                                                                        |
| kgd      | `kubectl get deployment`              | Get the deployment                                                                               |
| kgdw     | `kgd --watch`                         | After getting the deployment, watch for changes                                                  |
| kgdwide  | `kgd -o wide`                         | After getting the deployment, output in plain-text format with any additional information        |
| ked      | `kubectl edit deployment`             | Edit deployment resource from the default editor                                                 |
| kdd      | `kubectl describe deployment`         | Describe deployment resource in detail                                                           |
| kdeld    | `kubectl delete deployment`           | Delete the deployment                                                                            |
| ksd      | `kubectl scale deployment`            | Scale a deployment                                                                               |
| krsd     | `kubectl rollout status deployment`   | Check the rollout status of a deployment                                                         |
| kres     | `kubectl set env $@ REFRESHED_AT=...` | Recreate all pods in deployment with zero-downtime                                               |
|          |                                       | **Rollout management**                                                                           |
| kgrs     | `kubectl get rs`                      | To see the ReplicaSet `rs` created by the deployment                                             |
| krh      | `kubectl rollout history`             | Check the revisions of this deployment                                                           |
| kru      | `kubectl rollout undo`                | Rollback to the previous revision                                                                |
|          |                                       | **Port forwarding**                                                                              |
| kpf      | `kubectl port-forward`                | Forward one or more local ports to a pod                                                         |
|          |                                       | **Tools for accessing all information**                                                          |
| kga      | `kubectl get all`                     | List all resources in ps format                                                                  |
| kgaa     | `kubectl get all --all-namespaces`    | List the requested object(s) across all namespaces                                               |
|          |                                       | **Logs**                                                                                         |
| kl       | `kubectl logs`                        | Print the logs for a container or resource                                                       |
| klf      | `kubectl logs -f`                     | Stream the logs for a container or resource (follow)                                             |
|          |                                       | **File copy**                                                                                    |
| kcp      | `kubectl cp`                          | Copy files and directories to and from containers                                                |
|          |                                       | **Node management**                                                                              |
| kgno     | `kubectl get nodes`                   | List the nodes in ps output format                                                               |
| keno     | `kubectl edit node`                   | Edit nodes resource from the default editor                                                      |
| kdno     | `kubectl describe node`               | Describe node resource in detail                                                                 |
| kdelno   | `kubectl delete node`                 | Delete the node                                                                                  |
|          |                                       | **Persistent Volume Claim management**                                                           |
| kgpvc    | `kubectl get pvc`                     | List all PVCs                                                                                    |
| kgpvcw   | `kgpvc --watch`                       | After listing/getting the requested object, watch for changes                                    |
| kepvc    | `kubectl edit pvc`                    | Edit pvcs from the default editor                                                                |
| kdpvc    | `kubectl describe pvc`                | Describe all pvcs                                                                                |
| kdelpvc  | `kubectl delete pvc`                  | Delete all pvcs matching passed arguments                                                        |
|          |                                       | **StatefulSets management**                                                                      |
| kgss     | `kubectl get statefulset`             | List the statefulsets in ps format                                                               |
| kgssw    | `kgss --watch`                        | After getting the list of statefulsets, watch for changes                                        |
| kgsswide | `kgss -o wide`                        | After getting the statefulsets, output in plain-text format with any additional information      |
| kess     | `kubectl edit statefulset`            | Edit statefulset resource from the default editor                                                |
| kdss     | `kubectl describe statefulset`        | Describe statefulset resource in detail                                                          |
| kdelss   | `kubectl delete statefulset`          | Delete the statefulset                                                                           |
| ksss     | `kubectl scale statefulset`           | Scale a statefulset                                                                              |
| krsss    | `kubectl rollout status statefulset`  | Check the rollout status of a deployment                                                         |
|          |                                       | **Service Accounts management**                                                                  |
| kgsa     | `kubectl get sa`                      | List all service accounts                                                                        |
| kdsa     | `kubectl describe sa`                 | Describe a service account in details                                                            |
| kdelsa   | `kubectl delete sa`                   | Delete the service account                                                                       |
|          |                                       | **DaemonSet management**                                                                         |
| kgds     | `kubectl get daemonset`               | List all DaemonSets in ps output format                                                          |
| kgdsw    | `kgds --watch`                        | After listing all DaemonSets, watch for changes                                                  |
| keds     | `kubectl edit daemonset`              | Edit DaemonSets from the default editor                                                          |
| kdds     | `kubectl describe daemonset`          | Describe all DaemonSets in detail                                                                |
| kdelds   | `kubectl delete daemonset`            | Delete all DaemonSets matching passed argument                                                   |
|          |                                       | **CronJob management**                                                                           |
| kgcj     | `kubectl get cronjob`                 | List all CronJobs in ps output format                                                            |
| kecj     | `kubectl edit cronjob`                | Edit CronJob from the default editor                                                             |
| kdcj     | `kubectl describe cronjob`            | Describe a CronJob in details                                                                    |
| kdelcj   | `kubectl delete cronjob`              | Delete the CronJob                                                                               |

## git

| Alias                | Command                                                                                                                                                           |
| :------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| g                    | git                                                                                                                                                               |
| ga                   | git add                                                                                                                                                           |
| gaa                  | git add --all                                                                                                                                                     |
| gapa                 | git add --patch                                                                                                                                                   |
| gau                  | git add --update                                                                                                                                                  |
| gav                  | git add --verbose                                                                                                                                                 |
| gap                  | git apply                                                                                                                                                         |
| gapt                 | git apply --3way                                                                                                                                                  |
| gb                   | git branch                                                                                                                                                        |
| gba                  | git branch -a                                                                                                                                                     |
| gbd                  | git branch -d                                                                                                                                                     |
| gbda                 | git branch --no-color --merged \| command grep -vE "^(\+\|\*\|\s*($(git_main_branch)\|development\|develop\|devel\|dev)\s*$)" \| command xargs -n 1 git branch -d |
| gbD                  | git branch -D                                                                                                                                                     |
| gbl                  | git blame -b -w                                                                                                                                                   |
| gbnm                 | git branch --no-merged                                                                                                                                            |
| gbr                  | git branch --remote                                                                                                                                               |
| gbs                  | git bisect                                                                                                                                                        |
| gbsb                 | git bisect bad                                                                                                                                                    |
| gbsg                 | git bisect good                                                                                                                                                   |
| gbsr                 | git bisect reset                                                                                                                                                  |
| gbss                 | git bisect start                                                                                                                                                  |
| gc                   | git commit -v                                                                                                                                                     |
| gc!                  | git commit -v --amend                                                                                                                                             |
| gcn!                 | git commit -v --no-edit --amend                                                                                                                                   |
| gca                  | git commit -v -a                                                                                                                                                  |
| gca!                 | git commit -v -a --amend                                                                                                                                          |
| gcan!                | git commit -v -a --no-edit --amend                                                                                                                                |
| gcans!               | git commit -v -a -s --no-edit --amend                                                                                                                             |
| gcam                 | git commit -a -m                                                                                                                                                  |
| gcsm                 | git commit -s -m                                                                                                                                                  |
| gcb                  | git checkout -b                                                                                                                                                   |
| gcf                  | git config --list                                                                                                                                                 |
| gcl                  | git clone --recurse-submodules                                                                                                                                    |
| gclean               | git clean -id                                                                                                                                                     |
| gpristine            | git reset --hard && git clean -dffx                                                                                                                               |
| gcm                  | git checkout $(git_main_branch)                                                                                                                                   |
| gcd                  | git checkout develop                                                                                                                                              |
| gcmsg                | git commit -m                                                                                                                                                     |
| gco                  | git checkout                                                                                                                                                      |
| gcount               | git shortlog -sn                                                                                                                                                  |
| gcp                  | git cherry-pick                                                                                                                                                   |
| gcpa                 | git cherry-pick --abort                                                                                                                                           |
| gcpc                 | git cherry-pick --continue                                                                                                                                        |
| gcs                  | git commit -S                                                                                                                                                     |
| gd                   | git diff                                                                                                                                                          |
| gdca                 | git diff --cached                                                                                                                                                 |
| gdcw                 | git diff --cached --word-diff                                                                                                                                     |
| gdct                 | git describe --tags $(git rev-list --tags --max-count=1)                                                                                                          |
| gds                  | git diff --staged                                                                                                                                                 |
| gdt                  | git diff-tree --no-commit-id --name-only -r                                                                                                                       |
| gdnolock             | git diff $@ ":(exclude)package-lock.json" ":(exclude)\*.lock"                                                                                                     |
| gdv                  | git diff -w $@ \| view -                                                                                                                                          |
| gdw                  | git diff --word-diff                                                                                                                                              |
| gf                   | git fetch                                                                                                                                                         |
| gfa                  | git fetch --all --prune                                                                                                                                           |
| gfg                  | git ls-files \| grep                                                                                                                                              |
| gfo                  | git fetch origin                                                                                                                                                  |
| gg                   | git gui citool                                                                                                                                                    |
| gga                  | git gui citool --amend                                                                                                                                            |
| ggf                  | git push --force origin $(current_branch)                                                                                                                         |
| ggfl                 | git push --force-with-lease origin $(current_branch)                                                                                                              |
| ggl                  | git pull origin $(current_branch)                                                                                                                                 |
| ggp                  | git push origin $(current_branch)                                                                                                                                 |
| ggpnp                | ggl && ggp                                                                                                                                                        |
| ggpull               | git pull origin "$(git_current_branch)"                                                                                                                           |
| ggpur                | ggu                                                                                                                                                               |
| ggpush               | git push origin "$(git_current_branch)"                                                                                                                           |
| ggsup                | git branch --set-upstream-to=origin/$(git_current_branch)                                                                                                         |
| ggu                  | git pull --rebase origin $(current_branch)                                                                                                                        |
| gpsup                | git push --set-upstream origin $(git_current_branch)                                                                                                              |
| ghh                  | git help                                                                                                                                                          |
| gignore              | git update-index --assume-unchanged                                                                                                                               |
| gignored             | git ls-files -v \| grep "^[[:lower:]]"                                                                                                                            |
| git-svn-dcommit-push | git svn dcommit && git push github $(git_main_branch):svntrunk                                                                                                    |
| gk                   | gitk --all --branches                                                                                                                                             |
| gke                  | gitk --all $(git log -g --pretty=%h)                                                                                                                              |
| gl                   | git pull                                                                                                                                                          |
| glg                  | git log --stat                                                                                                                                                    |
| glgp                 | git log --stat -p                                                                                                                                                 |
| glgg                 | git log --graph                                                                                                                                                   |
| glgga                | git log --graph --decorate --all                                                                                                                                  |
| glgm                 | git log --graph --max-count=10                                                                                                                                    |
| glo                  | git log --oneline --decorate                                                                                                                                      |
| glol                 | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'                                                            |
| glols                | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat                                                     |
| glod                 | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'                                                            |
| glods                | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short                                               |
| glola                | git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all                                                      |
| glog                 | git log --oneline --decorate --graph                                                                                                                              |
| gloga                | git log --oneline --decorate --graph --all                                                                                                                        |
| glp                  | git log --pretty=\<format\>                                                                                                                                       |
| gm                   | git merge                                                                                                                                                         |
| gmom                 | git merge origin/$(git_main_branch)                                                                                                                               |
| gmt                  | git mergetool --no-prompt                                                                                                                                         |
| gmtvim               | git mergetool --no-prompt --tool=vimdiff                                                                                                                          |
| gmum                 | git merge upstream/$(git_main_branch)                                                                                                                             |
| gma                  | git merge --abort                                                                                                                                                 |
| gp                   | git push                                                                                                                                                          |
| gpd                  | git push --dry-run                                                                                                                                                |
| gpf                  | git push --force-with-lease                                                                                                                                       |
| gpf!                 | git push --force                                                                                                                                                  |
| gpoat                | git push origin --all && git push origin --tags                                                                                                                   |
| gpu                  | git push upstream                                                                                                                                                 |
| gpv                  | git push -v                                                                                                                                                       |
| gr                   | git remote                                                                                                                                                        |
| gra                  | git remote add                                                                                                                                                    |
| grb                  | git rebase                                                                                                                                                        |
| grba                 | git rebase --abort                                                                                                                                                |
| grbc                 | git rebase --continue                                                                                                                                             |
| grbd                 | git rebase develop                                                                                                                                                |
| grbi                 | git rebase -i                                                                                                                                                     |
| grbm                 | git rebase $(git_main_branch)                                                                                                                                     |
| grbo                 | git rebase --onto                                                                                                                                                 |
| grbs                 | git rebase --skip                                                                                                                                                 |
| grev                 | git revert                                                                                                                                                        |
| grh                  | git reset                                                                                                                                                         |
| grhh                 | git reset --hard                                                                                                                                                  |
| groh                 | git reset origin/$(git_current_branch) --hard                                                                                                                     |
| grm                  | git rm                                                                                                                                                            |
| grmc                 | git rm --cached                                                                                                                                                   |
| grmv                 | git remote rename                                                                                                                                                 |
| grrm                 | git remote remove                                                                                                                                                 |
| grs                  | git restore                                                                                                                                                       |
| grset                | git remote set-url                                                                                                                                                |
| grss                 | git restore --source                                                                                                                                              |
| grst                 | git restore --staged                                                                                                                                              |
| grt                  | cd "$(git rev-parse --show-toplevel \|\| echo .)"                                                                                                                 |
| gru                  | git reset --                                                                                                                                                      |
| grup                 | git remote update                                                                                                                                                 |
| grv                  | git remote -v                                                                                                                                                     |
| gsb                  | git status -sb                                                                                                                                                    |
| gsd                  | git svn dcommit                                                                                                                                                   |
| gsh                  | git show                                                                                                                                                          |
| gsi                  | git submodule init                                                                                                                                                |
| gsps                 | git show --pretty=short --show-signature                                                                                                                          |
| gsr                  | git svn rebase                                                                                                                                                    |
| gss                  | git status -s                                                                                                                                                     |
| gst                  | git status                                                                                                                                                        |
| gsta                 | git stash push                                                                                                                                                    |
| gsta                 | git stash save                                                                                                                                                    |
| gstaa                | git stash apply                                                                                                                                                   |
| gstc                 | git stash clear                                                                                                                                                   |
| gstd                 | git stash drop                                                                                                                                                    |
| gstl                 | git stash list                                                                                                                                                    |
| gstp                 | git stash pop                                                                                                                                                     |
| gsts                 | git stash show --text                                                                                                                                             |
| gstu                 | git stash --include-untracked                                                                                                                                     |
| gstall               | git stash --all                                                                                                                                                   |
| gsu                  | git submodule update                                                                                                                                              |
| gsw                  | git switch                                                                                                                                                        |
| gswc                 | git switch -c                                                                                                                                                     |
| gts                  | git tag -s                                                                                                                                                        |
| gtv                  | git tag \| sort -V                                                                                                                                                |
| gtl                  | gtl(){ git tag --sort=-v:refname -n -l ${1}\* }; noglob gtl                                                                                                       |
| gunignore            | git update-index --no-assume-unchanged                                                                                                                            |
| gunwip               | git log -n 1 \| grep -q -c "\-\-wip\-\-" && git reset HEAD~1                                                                                                      |
| gup                  | git pull --rebase                                                                                                                                                 |
| gupv                 | git pull --rebase -v                                                                                                                                              |
| gupa                 | git pull --rebase --autostash                                                                                                                                     |
| gupav                | git pull --rebase --autostash -v                                                                                                                                  |
| glum                 | git pull upstream $(git_main_branch)                                                                                                                              |
| gwch                 | git whatchanged -p --abbrev-commit --pretty=medium                                                                                                                |
| gwip                 | git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"                                            |
| gam                  | git am                                                                                                                                                            |
| gamc                 | git am --continue                                                                                                                                                 |
| gams                 | git am --skip                                                                                                                                                     |
| gama                 | git am --abort                                                                                                                                                    |
| gamscp               | git am --show-current-patch                                                                                                                                       |

## git flow

| Alias   | Command                    | Description                            |
| ------- | -------------------------- | -------------------------------------- |
| `gfl`   | `git flow`                 | Git-Flow command                       |
| `gfli`  | `git flow init`            | Initialize git-flow repository         |
| `gcd`   | `git checkout develop`     | Check out develop branch               |
| `gch`   | `git checkout hotfix`      | Check out hotfix branch                |
| `gcr`   | `git checkout release`     | Check out release branch               |
| `gflf`  | `git flow feature`         | List existing feature branches         |
| `gflh`  | `git flow hotfix`          | List existing hotfix branches          |
| `gflr`  | `git flow release`         | List existing release branches         |
| `gflfs` | `git flow feature start`   | Start a new feature: `gflfs <name>`    |
| `gflhs` | `git flow hotfix start`    | Start a new hotfix: `gflhs <version>`  |
| `gflrs` | `git flow release start`   | Start a new release: `gflrs <version>` |
| `gflff` | `git flow feature finish`  | Finish feature: `gflff <name>`         |
| `gflfp` | `git flow feature publish` | Publish feature: `gflfp <name>`        |
| `gflhf` | `git flow hotfix finish`   | Finish hotfix: `gflhf <version>`       |
| `gflrf` | `git flow release finish`  | Finish release: `gflrf <version>`      |

## systemd

| Alias                  | Command                            | Description                                                      |
| :--------------------- | :--------------------------------- | :--------------------------------------------------------------- |
| `sc-list-units`        | `systemctl list-units`             | List all units systemd has in memory                             |
| `sc-is-active`         | `systemctl is-active`              | Show whether a unit is active                                    |
| `sc-status`            | `systemctl status`                 | Show terse runtime status information about one or more units    |
| `sc-show`              | `systemctl show`                   | Show properties of units, jobs, or the manager itself            |
| `sc-help`              | `systemctl help`                   | Show man page of units                                           |
| `sc-list-unit-files`   | `systemctl list-unit-files`        | List unit files installed on the system                          |
| `sc-is-enabled`        | `systemctl is-enabled`             | Checks whether any of the specified unit files are enabled       |
| `sc-list-jobs`         | `systemctl list-jobs`              | List jobs that are in progress                                   |
| `sc-show-environment`  | `systemctl show-environment`       | Dump the systemd manager environment block                       |
| `sc-cat`               | `systemctl cat`                    | Show backing files of one or more units                          |
| `sc-list-timers`       | `systemctl list-timers`            | List timer units currently in memory                             |
| **Aliases with sudo**  |                                    |                                                                  |
| `sc-start`             | `sudo systemctl start`             | Start Unit(s)                                                    |
| `sc-stop`              | `sudo systemctl stop`              | Stop Unit(s)                                                     |
| `sc-reload`            | `sudo systemctl reload`            | Reload Unit(s)                                                   |
| `sc-restart`           | `sudo systemctl restart`           | Restart Unit(s)                                                  |
| `sc-try-restart`       | `sudo systemctl try-restart`       | Restart Unit(s)                                                  |
| `sc-isolate`           | `sudo systemctl isolate`           | Start a unit and its dependencies and stop all others            |
| `sc-kill`              | `sudo systemctl kill`              | Kill unit(s)                                                     |
| `sc-reset-failed`      | `sudo systemctl reset-failed`      | Reset the "failed" state of the specified units,                 |
| `sc-enable`            | `sudo systemctl enable`            | Enable unit(s)                                                   |
| `sc-disable`           | `sudo systemctl disable`           | Disable unit(s)                                                  |
| `sc-reenable`          | `sudo systemctl reenable`          | Reenable unit(s)                                                 |
| `sc-preset`            | `sudo systemctl preset`            | Reset the enable/disable status one or more unit files           |
| `sc-mask`              | `sudo systemctl mask`              | Mask unit(s)                                                     |
| `sc-unmask`            | `sudo systemctl unmask`            | Unmask unit(s)                                                   |
| `sc-link`              | `sudo systemctl link`              | Link a unit file into the unit file search path                  |
| `sc-load`              | `sudo systemctl load`              | Load unit(s)                                                     |
| `sc-cancel`            | `sudo systemctl cancel`            | Cancel job(s)                                                    |
| `sc-set-environment`   | `sudo systemctl set-environment`   | Set one or more systemd manager environment variables            |
| `sc-unset-environment` | `sudo systemctl unset-environment` | Unset one or more systemd manager environment variables          |
| `sc-edit`              | `sudo systemctl edit`              | Edit a drop-in snippet or a whole replacement file with `--full` |
| `sc-enable-now`        | `sudo systemctl enable --now`      | Enable and start unit(s)                                         |
| `sc-disable-now`       | `sudo systemctl disable --now`     | Disable and stop unit(s)                                         |
| `sc-mask-now`          | `sudo systemctl mask --now`        | Mask and stop unit(s)                                            |

## Vagrant

| Alias   | Command                      |
| ------- | ---------------------------- |
| `vgi`   | `vagrant init`               |
| `vup`   | `vagrant up`                 |
| `vd`    | `vagrant destroy`            |
| `vdf`   | `vagrant destroy -f`         |
| `vssh`  | `vagrant ssh`                |
| `vsshc` | `vagrant ssh-config`         |
| `vrdp`  | `vagrant rdp`                |
| `vh`    | `vagrant halt`               |
| `vssp`  | `vagrant suspend`            |
| `vst`   | `vagrant status`             |
| `vre`   | `vagrant resume`             |
| `vgs`   | `vagrant global-status`      |
| `vpr`   | `vagrant provision`          |
| `vr`    | `vagrant reload`             |
| `vrp`   | `vagrant reload --provision` |
| `vp`    | `vagrant push`               |
| `vsh`   | `vagrant share`              |
| `vba`   | `vagrant box add`            |
| `vbr`   | `vagrant box remove`         |
| `vbl`   | `vagrant box list`           |
| `vbo`   | `vagrant box outdated`       |
| `vbu`   | `vagrant box update`         |
| `vpli`  | `vagrant plugin install`     |
| `vpll`  | `vagrant plugin list`        |
| `vplun` | `vagrant plugin uninstall`   |
| `vplu`  | `vagrant plugin update`      |

---

## Maccy

### Usage

1. <kbd>SHIFT (⇧)</kbd> + <kbd>COMMAND (⌘)</kbd> + <kbd>C</kbd> to popup Maccy or click on its icon in the menu bar.
2. Type what you want to find.
3. To select the history item you wish to copy, press <kbd>ENTER</kbd>, or click the item, or use <kbd>COMMAND (⌘)</kbd> + `n` shortcut.
4. To choose the history item and paste, press <kbd>OPTION (⌥)</kbd> + <kbd>ENTER</kbd>, or <kbd>OPTION (⌥)</kbd> + <kbd>CLICK</kbd> the item, or use <kbd>OPTION (⌥)</kbd> + `n` shortcut.
5. To choose the history item and paste without formatting, press <kbd>OPTION (⌥)</kbd> + <kbd>SHIFT (⇧)</kbd> + <kbd>ENTER</kbd>, or <kbd>OPTION (⌥)</kbd> + <kbd>SHIFT (⇧)</kbd> + <kbd>CLICK</kbd> the item, or use <kbd>OPTION (⌥)</kbd> + <kbd>SHIFT (⇧)</kbd> + `n` shortcut.
6. To delete the history item, press <kbd>OPTION (⌥)</kbd> + <kbd>DELETE (⌫)</kbd>.
7. To see the full text of the history item, wait a couple of seconds for tooltip.
8. To pin the history item so that it remains on top of the list, press <kbd>OPTION (⌥)</kbd> + <kbd>P</kbd>. The item will be moved to the top with a random but permanent keyboard shortcut. To unpin it, press <kbd>OPTION (⌥)</kbd> + <kbd>P</kbd> again.
9. To clear all unpinned items, select _Clear_ in the menu, or press <kbd>OPTION (⌥)</kbd> + <kbd>COMMAND (⌘)</kbd> + <kbd>DELETE (⌫)</kbd>. To clear all items including pinned, select _Clear_ in the menu with <kbd>OPTION (⌥)</kbd> pressed, or press <kbd>SHIFT (⇧)</kbd> + <kbd>OPTION (⌥)</kbd> + <kbd>COMMAND (⌘)</kbd> + <kbd>DELETE (⌫)</kbd>.
10. To customize the behavior, check "Preferences..." window, or press <kbd>COMMAND (⌘)</kbd> + <kbd>,</kbd>.
