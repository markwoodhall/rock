.PHONY: all debug

COMMIT_REF=$(shell git rev-parse --short HEAD)
SOURCE_AMI?="ami-054280c303cf1a3e1d"
AWS_REGION?="eu-west-1"

all: 	clean
	packer-io build \
		-var "commit_ref=$(COMMIT_REF)" \
		-var "source_ami=$(SOURCE_AMI)" \
		-var "aws_region=$(AWS_REGION)" \
		-var "ami_regions=$(AMI_REGIONS)" \
		rock.json

# We need to clean up any build artefacts in the package directories because
# they won't have right permissions, and may conflict with what we want to build
# inside the VM.
clean:
	rm -rf share/*/{src,pkg}

debug:
	packer-io build -debug \
		-var "commit_ref=$(COMMIT_REF)" \
		-var "source_ami=$(SOURCE_AMI)" \
		-var "aws_region=$(AWS_REGION)" \
		-var "ami_regions=$(AMI_REGIONS)" \
		rock.json

test:
	shellcheck **/*.sh
