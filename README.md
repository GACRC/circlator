# circlator
Dockerfile for Circlator.

# Run Container

## Check dependencies

   docker run --rm aquaron/circlator progcheck

## PacBio data

Given an assembly `assembly.fasta` in FASTA format and corrected PacBio reads in a file called, `reads.pacbio`, run:

   docker run --rm -v /tmp/data:/data aquaron/circlator all assembly.fasta reads.pacbio /data

# sanger-pathogens/circlator
You can find source information here:

https://github.com/sanger-pathogens/circlator

