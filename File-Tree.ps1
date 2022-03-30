new-item "$env:userprofile/desktop/root-directory" -type d
new-item "$env:userprofile/desktop/root-directory/file1" -type f
new-item "$env:userprofile/desktop/root-directory/folder1","root-directory/folder2","root-directory/folder3" -type d
new-item "$env:userprofile/desktop/root-directory/folder1/file2","root-directory/folder1/file3" -type f
new-item "$env:userprofile/desktop/root-directory/folder2/folder4","root-directory/folder2/folder5" -type d
new-item "$env:userprofile/desktop/root-directory/folder2/folder4/file4","root-directory/folder2/folder4/file5" -type f

write-host "Les fichiers ont bien ete creer .."

Pause
