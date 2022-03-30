$state = "True"
While ($state -eq "True") {
  write-host "

---MENU---
[1] Creer un utilisateur
[2] Supprimer un utilisateur
[3] Creer un groupe
[4] Supprimer un groupe
[5] Ajouter un utilisateur a un groupe
[6] Supprimer un utilisateur d'un groupe
[7] Changer les options de profile d'un utilisateur

"

  $users = (get-localuser)
  $groups = (get-localgroup)

  $variable = read-host "[SCRIPT]"
  if ($variable -eq 1) {
    write-host "Utilisateurs existants : $users"
    $login = read-host "Quel est le login du nouvel utilisateur ?:"
    $name = read-host "Quel est le nom complet du nouvel utilisateur ?:"
    $password = read-host "Quel est le mot de passe de l'utilisateur ?:" -AsSecureString
    new-localuser $login -fullname $name -password $password -usermaynotchangepassword
    add-localgroupmember -group users -member $login
    write-host "LOG : L'utilisateur $name a bien été ajoute"
  } elseif ($variable -eq 2) {
    write-host "Utilisateurs existants : $users"
    $rm = read-host "Quel est le login de l'utilisateur à supprimer ?:"
    remove-localuser $rm
    write-host "LOG : L'utilisateur possédant le login $rm a bien ete supprime"
  } elseif ($variable -eq 3) {
    write-host "Groupes existants : $groups"
    $groupname = read-host "Quel est le nom du groupe à creer ?:"
    new-localgroup $groupname
    write-host "Le groupe $groupname a bien ete creer"
  } elseif ($variable -eq 4) {
    write-host "Groupes existants : $groups"
    $rm = read-host "Quel est le nom du groupe a supprimer ?:"
    remove-localgroup $rm
    write-host "Le groupe $rm a bien ete supprime"
  } elseif ($variable -eq 5) {
    write-host "Utilisateurs existants : $users"
    $adduser = read-host "Quel utilisateur voulez-vous ajouter dansun groupe ?:"
    write-host "Groupes existants : $groups"
    $addgroup = read-host "Dans quel groupe voulez-vous ajouter cet utilisateur ?:"
    add-localgroupmember -group $addgroup -member $adduser
    write-host "L'utilisateur $adduser a bien ete ajoute dans le groupe $addgroupe"
  } elseif ($variable -eq 6) {
    write-host "Groupes existants : $groups"
    $rmgroup = read-host "Dans quel groupe voulez-vous supprimer un utilisateur ?:"
    $groupmembers = (get-localgroupmember -group $rmgroup)
    write-host "Utilisateurs dans ce groupe : $groupmembers"
    $rmuser = read-host "Quel utilisateur voulez-vous supprimer dans ce groupe ?:"
    remove-localgroupmember -group $rmgroup -member $rmuser
    write-host "L'utilisateur $rmuser a bien ete supprime du groupe $rmgroup"
  }
}
