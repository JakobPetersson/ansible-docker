#!/usr/bin/env sh
#
# Build docker image for ansible and run Ansible playbook
#

set -eu

THIS_DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"

#
# Build container image for ansible
# Save image to to .ansible_image_id
#
build_ansible_image() {
  (
    cd "${THIS_DIR}"
    docker build \
      --quiet \
      --tag docker-ansible \
      --iidfile ".ansible_image_id" \
      .
  )
}

#
# Run ansible playbook using Ansible image.
# Mounts current directory '.' as workdir.
#
run_ansible_playbook() {
  docker run \
    --volume "$(pwd)":/work:ro \
    --volume ~/.ssh:/root/.ssh:ro \
    --rm \
    -it \
    "$(cat "${THIS_DIR}/.ansible_image_id")" \
    ansible-playbook \
    "$@"
}

# Always build image if needed
build_ansible_image

# Run Ansible playbook with all arguments forwarded
run_ansible_playbook "$@"
