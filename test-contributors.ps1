# Test script to fetch contributors
$repoOwner = 'deadlydog'
$repoName = 'PowerShell.tiPS'
$maxContributors = 100

Write-Host "Fetching contributors from GitHub API..."
$contributorsApiUrl = "https://api.github.com/repos/$repoOwner/$repoName/contributors?per_page=$maxContributors"

try {
    $contributors = Invoke-RestMethod -Uri $contributorsApiUrl -Headers @{
        'Accept' = 'application/vnd.github.v3+json'
        'User-Agent' = 'PowerShell-Script'
    }
    
    Write-Host "Found $($contributors.Count) contributors."
    
    if ($contributors.Count -eq 0) {
        Write-Warning "No contributors found."
    } else {
        # Display first 5 contributors for testing
        $contributors | Select-Object -First 5 login, html_url, avatar_url | Format-Table
    }
} catch {
    Write-Warning "Error fetching contributors: $_"
}