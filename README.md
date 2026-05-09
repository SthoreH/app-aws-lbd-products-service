# app-aws-lbd-products-service

AWS Lambda for the products service.

## Project layout

- [app/src/](app/src/) — Lambda source code.
- [app/tests/](app/tests/) — test suite.
- [terraform-aws/](terraform-aws/) — IaC for the Lambda function and its IAM role.
- [.pipeline.yml](.pipeline.yml) — pipeline configuration consumed by the shared workflows.

## Repository configuration

The pipeline expects two GitHub Environments — `dev` and `prod` — each defining the variables `AWS_ROLE_ARN` and `TF_STATE_BUCKET`. The IAM role's trust policy must accept GitHub OIDC from this repository.

Branch and tag protection are managed via the rulesets in [.github/rulesets/](.github/rulesets/). Import them via `Settings → Rules → Rulesets → New ruleset → Import a ruleset`.

## Pipeline

Caller workflows live in [.github/workflows/](.github/workflows/). They are thin wrappers around the reusable workflows and composite actions in [shd-github-actions-workflows](../../shd/shd-github-actions-workflows/) — see that repo's README for what each piece does.

- [ci-dev.yml](.github/workflows/ci-dev.yml), [ci-prod.yml](.github/workflows/ci-prod.yml) — PR validation.
- [deploy-dev.yml](.github/workflows/deploy-dev.yml), [deploy-prod.yml](.github/workflows/deploy-prod.yml) — deploys on push to `dev` / `main`.
- [rollback.yml](.github/workflows/rollback.yml) — re-deploys at a previous tag via labeled issue.
- [destroy.yml](.github/workflows/destroy.yml) — tears down `dev` via labeled issue.

## Operations

**Rollback** — open an issue using the [rollback request template](.github/ISSUE_TEMPLATE/rollback_request.yml) and apply the `rollback-approved` label.

**Destroy** — open an issue using the [destroy request template](.github/ISSUE_TEMPLATE/destroy_request.yml) and apply the `destroy-approved` label. Restricted to `dev`; `prod` destruction is a manual CLI operation.
