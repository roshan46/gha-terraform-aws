# Manual-review alternative

Use only when your GitHub plan cannot enforce environment approval. This is weaker than independent enforced review.

First apply the regular Lab 10 overlay, then copy this directory's hidden .github folder over the repository .github folder. Review and commit the two workflow files. The replacement deploy.yml contains only plan; manual-apply.yml is a separate dispatch.

Run Terraform plan only from main. Review private plan.txt using your operator session. Record the exact run ID, attempt, source SHA, and binary SHA256 from the plan summary. Dispatch Terraform manually reviewed apply on the same main commit and enter those four values. It validates the input shape, current source, private object checksum, and applies the saved binary under the same concurrency group.

Do not run this alongside the combined automatic apply workflow. This variant replaces it. Only trusted maintainers may dispatch it. A human can still skip or misrepresent review; record that limitation in capstone evidence.
