param(
    [string]$Remote = "origin",
    [string]$BaseBranch = "main"
)

$ErrorActionPreference = "Stop"

$repoRoot = (git rev-parse --show-toplevel 2>$null)
if (-not $repoRoot) {
    Write-Error "Not inside a git repository."
    exit 1
}

Set-Location $repoRoot

$currentBranch = (git branch --show-current).Trim()
if (-not $currentBranch) {
    Write-Error "Could not determine current branch."
    exit 1
}

# Only block on tracked file changes; untracked files are allowed.
$trackedChanges = git status --porcelain --untracked-files=no
if ($trackedChanges) {
    Write-Error "Tracked changes detected. Commit or stash before running safe sync."
    exit 1
}

Write-Host "Fetching latest refs from $Remote..."
git fetch $Remote --prune

if ($currentBranch -eq $BaseBranch) {
    Write-Host "On ${BaseBranch}: pulling latest with fast-forward only..."
    git pull --ff-only $Remote $BaseBranch
} else {
    Write-Host "Refreshing local $BaseBranch pointer from $Remote/$BaseBranch..."
    git show-ref --verify --quiet "refs/heads/$BaseBranch"
    if ($LASTEXITCODE -eq 0) {
        git branch -f $BaseBranch "$Remote/$BaseBranch"
    } else {
        git branch $BaseBranch "$Remote/$BaseBranch"
    }

    Write-Host "Rebasing $currentBranch onto $Remote/$BaseBranch..."
    git rebase "$Remote/$BaseBranch"
}

Write-Host "Safe sync complete. Current branch: $(git branch --show-current)"
git status -sb
