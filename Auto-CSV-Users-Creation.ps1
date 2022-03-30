$utilisateurs = import-csv users.csv -Delimiter ";"

foreach ($getuser in $utilisateurs) {
    if ($getuser.LOGIN -eq "") {
        write-host "ERROR : L'utilisateur " $getuser.NOM " " $getuser.PRENOM " n'a pas de login defini."
        $loginrecover = read-host "Quel est le login du compte" $getuser.NOM " " $getuser.PRENOM
        $password = (ConvertTo-SecureString -AsPlainText $getuser.PASSWORD -Force)
        $fullname = $getuser.NOM + ' ' + $getuser.PRENOM + '.'
        New-LocalUser $loginrecover -Password $password -FullName $fullname -Description "Auto create."
        Add-LocalGroupMember -group $getuser.SERVICE -member $loginrecover
    } elseif ($getuser.NOM -eq "") {
        write-host "ERROR : L'utilisateur " $getuser.LOGIN " n'a pas de nom defini."
        $nomrecover = read-host "Quel est le nom du compte" $getuser.LOGIN
        $password = (ConvertTo-SecureString -AsPlainText $getuser.PASSWORD -Force)
        $fullname = $nomrecover + ' ' + $getuser.PRENOM + '.'
        New-LocalUser $getuser.LOGIN -Password $password -FullName $fullname -Description "Auto create."
        Add-LocalGroupMember -group $getuser.SERVICE -member $getuser.LOGIN
    } elseif ($getuser.PRENOM -eq "") {
        write-host "ERROR : L'utilisateur " $getuser.LOGIN " n'a pas de prenom defini."
        $prenomrecover = read-host "Quel est le prenom du compte" $getuser.LOGIN
        $password = (ConvertTo-SecureString -AsPlainText $getuser.PASSWORD -Force)
        $fullname = $getuser.NOM + ' ' + $prenomrecover + '.'
        New-LocalUser $getuser.LOGIN -Password $password -FullName $fullname -Description "Auto create."
        Add-LocalGroupMember -group $getuser.SERVICE -member $getuser.LOGIN
    } elseif ($getuser.PASSWORD -eq "") {
        write-host "ERROR : L'utilisateur " $getuser.LOGIN " n'a pas de mot de passe defini."
        $passwordrecover = read-host "Quel est le mot de passe du compte" $getuser.LOGIN -AsSecureString
        $fullname = $getuser.NOM + ' ' + $getuser.PRENOM + '.'
        New-LocalUser $getuser.LOGIN -Password $passwordrecover -FullName $fullname -Description "Auto create."
        Add-LocalGroupMember -group $getuser.SERVICE -member $getuser.LOGIN
    } elseif ($getuser.SERVICE -eq "") {
        write-host "ERROR : L'utilisateur " $getuser.LOGIN " n'a pas de groupe defini."
        $grouplist = Get-LocalGroup
        write-host $grouplist
        $grouprecover = read-host "Quel est le groupe du compte" $getuser.LOGIN
        $fullname = $getuser.NOM + ' ' + $getuser.PRENOM + '.'
        $password = (ConvertTo-SecureString -AsPlainText $getuser.PASSWORD -Force)
        New-LocalUser $getuser.LOGIN -Password $password -FullName $fullname -Description "Auto create."
        Add-LocalGroupMember -group $grouprecover -member $getuser.LOGIN
    } else {
        $password = (ConvertTo-SecureString -AsPlainText $getuser.PASSWORD -Force)
        $fullname = $getuser.NOM + ' ' + $getuser.PRENOM + '.'
        New-LocalUser $getuser.LOGIN -Password $password -FullName $fullname -Description "Auto create."
        Add-LocalGroupMember -group $getuser.SERVICE -member $getuser.LOGIN
    }
}
