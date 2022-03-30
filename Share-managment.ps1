$state = "True"

While ($state -eq "True") {
    write-host "

--MENU--
[1] Partager un dossier
[2] Supprimer un partage
[3] Modifier un partage
[4] Voir les partages

"

    $users = (get-localuser)
    $groups = (get-localgroup)

    $variable = read-host "[SCRIPT]"
    if ($variable -eq 1) {
        $name = read-host "Quel est le nom du partage ?"
        $path = read-host "Quel est le chemin du fichier a partager ?"
        $group = read-host "Quel est le goupe avec lequel partager ?"
        write-host "
        
        --TYPE--
[1] Donner tout les acces
[2] Donner les permissions de lire
[3] Supprimer tout les acces
        
"
        $type = read-host "[SCRIPT/TYPE]"
        if ($type -eq 1) {
            New-SmbShare -Name $name -Path $path -FullAccess $group
            write-host "Le partage a bizen ete creer"
        } elseif ($type -eq 2) {
            New-SmbShare -Name $name -Path $path -ReadAccess $group
            write-host "Le partage a bizen ete creer"
        } elseif ($type -eq 3) {
            New-SmbShare -Name $name -Path $path -NoAccess $group
            write-host "Le partage a bizen ete creer"
        }
    } elseif ($variable -eq 2) {
        $name = read-host "Quel est le nom du partage a supprimer ?"
        Remove-SmbShare -Name $name -Confirm
        write-host "Le partage a bien ete supprime"
    } elseif ($variable -eq 3) {
        $name = read-host "Quel est le nom du partage a modifier ?"
        $accname = read-host "De quel groupe voulez-vous modifier les acces ?"
        write-host "
        
        --TYPE--
[1] Donner tout les acces
[2] Donner les permissions de modifier
[3] Donner les permissions d'ecrire
        
"
        $type = read-host "[SCRIPT/TYPE]"
        if ($type -eq 1) {
            Grant-SmbShareAccess -Name $name -AccountName $accname -AccessRight Full -Confirm
        } elseif ($type -eq 2) {
            Grant-SmbShareAccess -Name $name -AccountName $accname -AccessRight Change -Confirm
        } elseif ($type -eq 3) {
            Grant-SmbShareAccess -Name $name -AccountName $accname -AccessRight Read -Confirm
        }
    } elseif ($variable -eq 4) {
        $shares = (get-SmbShare)
        write-host "Listes des partages : $shares"
    }
}
