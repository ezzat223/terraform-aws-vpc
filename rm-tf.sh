#!/bin/bash
# WARNING!! This script will clean-up all terraform files of prev build
# Use it only after destroy

rm -rf terraform.tfstate
rm -rf terraform.tfstate.*
rm -rf .terraform
rm -rf .terraform.*
