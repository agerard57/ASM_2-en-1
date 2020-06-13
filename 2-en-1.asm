TITLE   DISPLAY - 2-en-1
.286

ASSUME SS:SSEG, DS:DSEG, CS:CSEG    ; Assume que SS = Stack Segment, DS = Data Segment et CS = Code Segment

SSEG        SEGMENT STACK 'STACK'
DB      32      DUP("STACK---")
SSEG        ENDS

DSEG        SEGMENT 'DATA'

nomfichier db "score.txt",0
handle dw ?

    TON                 DW 2280    ; 2280 pour faire un do

    TITRE_JEU           DB "PROJET 2-EN-1"

 TEST1 DB    "'  __       ___           "
 TEST2 DB    "  '__/ ___ |___ |\ | ___ |"
 TEST3 DB    "  |__      |___ | \|     |"

;------------------------------------------- 1 - LA GRIPPE ------------------------------------------;

   GRIPPE               DB "1-LA GRIPPE"

      TXTGRIPPE1         DB     "     __    __  __   __  __  __ "
      TXTGRIPPE2         DB     "|   |__|  | _ |__|||__]|__]|_  "
      TXTGRIPPE3         DB     "|___|  |  |__]|  \||   |   |__ "

      JOUER_GRIPPE         DB "1-JOUER"

        TITRE_DIFFI            DB "SELECTIONNE LA DIFFICULTE"
        BENIN                DB "1-BENIN (FACILE)"
        VIRUL                DB "2-VIRULENT (NORMAL)"
        MORTEL               DB "3-MORTEL (DIFFICILE)"

      AIDE_GRIPPE          DB "2-AIDE"

        AIDEGRIPPE0          DB "AIDE GRIPPE :"
	    AIDEGRIPPE1          DB "Pour se deplacer"
	    AIDEGRIPPE2          DB "Z Q S D"

      PARA_GRIPPE          DB "3-PARAMETRES"

        PARAGRIPPE0        DB "TEST"



;--------------------------------------------- 2 - TRON ---------------------------------------------;

   TRON                 DB "2-TRON"

        TXTRON0              DB    "___ __  __     "
        TXTRON1              DB    " | |__)/  \|\ |"
        TXTRON2              DB    " | | \ \__/| \|"

        JOUER_TRON           DB "1-JOUER"
        AIDE_TRON            DB "2-AIDE"

            AIDETRON0            DB "AIDE TRON :"
            AIDETRON1            DB "Pour se deplacer"
	        AIDETRON2            DB "Z Q S D et I J K L"

      PARA_TRON              DB "3-PARAMETRES"

            PARATRON0            DB "TEST"

;------------------------------------------- 3 - A PROPOS -------------------------------------------;

   A_PROPOS             DB "3-A PROPOS"

       A_PROP0              DB "Fait par :"
	   A_PROP1              DB "GERARD Alexandre"
	   A_PROP2              DB "POIRE Nicolas"
	   A_PROP3              DB "Groupe 3.2"
	   A_PROP4              DB "20/04/2020"
	   A_PROP5              DB "PROJET ASSEMBLEUR"
	   A_PROP6              DB "IUT METZ"
       A_PROP7              DB "VERSION 1.5"

;-------------------------------------------- 4 - QUITTER -------------------------------------------;

   QUITTER              DB "4-QUITTER"



    MSG_FIN1            DB "Voulez-vous QUITTER (Q),"
    MSG_FIN2            DB "aller au MENU (M)"
    MSG_FIN3            DB "oou RECOMMENCER (R) ?"


    I                   DW 00H             ; Varible d'incrémentation
    J                   DB 30H             ; Variable d'incrémentation sur 8bit
    k                   DB 30H

;#######################################################################;
;#                          DATA POUR GRIPPE                           #;
;#######################################################################;



    PERDU_GRIPPE        DB "PERDU ! Vous avez ete infecte !"


    LARGEUR_ECRAN       DW 0140H          ; Largeur de l'écran en hexa (320 px)
    LONGEUR_ECRAN       DW 00C8H          ; Longeur de l'écran en hexa (200 px)
    LIMITE_ECRAN        DW 06H            ; Utilisé pour vérifier les collisions plus tôt

    TEMPS_ALT           DB 00H            ; Variable utilisé pour vérifier si le temps à changer
    TEMPS_ALT2          DB 00H            ; Variable pour effacer l'écran

    JOUEUR_X            DW 009BH          ; Position X du joueur
    JOUEUR_Y            DW 005FH          ; Position Y du joueur
    JOUEUR_TAILLE       DW 0BH            ; Taille en pixels du joueur
    VITESSE_JOUEUR      DW 03H            ; Vitesse de déplacement du joueur (en pixels) lorcequ'on appuie sur une touche

    ENNEMIS_X           DW 00H            ; Position X ennemis
    ENNEMIS_Y           DW 00H            ; Position Y
    ENNEMIS_TAILLE      DW 0BH            ; Taille en pixels de l'ennemis
    VITESSE_ENNEMIS_X   DW 00H            ; Vitesse X ennemis
    VITESSE_ENNEMIS_Y   DW 00H            ; Vitesse Y ennemis
    TEMP_X              DW 00H
    TEMP_Y              DW 00H

    ENNEMIS1_X          DW 00H            ; Position X ennemis
    ENNEMIS1_Y          DW 00H            ; Position Y ennemis
    ENNEMIS1_TAILLE     DW 0AH            ; Taille en pixels de l'ennemis
    VITESSE_ENNEMIS1_X  DW 01H            ; Vitesse X ennemis
    VITESSE_ENNEMIS1_Y  DW 01H            ; Vitesse Y ennemis

    ENNEMIS2_X          DW 00H            ; Position X ennemis
    ENNEMIS2_Y          DW 00H            ; Position Y ennemis
    ENNEMIS2_TAILLE     DW 0AH            ; Taille en pixels de l'ennemis
    VITESSE_ENNEMIS2_X  DW 02H            ; Vitesse X ennemis
    VITESSE_ENNEMIS2_Y  DW 02H            ; Vitesse Y ennemis

    ENNEMIS3_X          DW 00H            ; Position X ennemis
    ENNEMIS3_Y          DW 00H            ; Position Y ennemis
    ENNEMIS3_TAILLE     DW 0AH            ; Taille en pixels de l'ennemis
    VITESSE_ENNEMIS3_X  DW 03H            ; Vitesse X ennemis
    VITESSE_ENNEMIS3_Y  DW 03H            ; Vitesse Y ennemis

    V_DIFF              DW 01H

    SCORE_CENTAINE      DB 30H            ; Initialisation à 30H equivalent à 0 en ASCII
    SCORE_DIZAINE       DB 30H            ; Score afficher pendant le jeux
    SCORE_UNITE         DB 30H

    SCORE_CENTAINE_FINI DB 30H            ; Score final afficher sur l'écran de fin
    SCORE_DIZAINE_FINI  DB 30H
    SCORE_UNITE_FINI    DB 30H

    STIME               DB 0H             ; STIME est la variable temps (en secondes) utiliser
                                          ; pour calculer le score qui augmente de 1/seconde
    PERDU               DW 0H             ; Variable indiquant si le joueur à perdu (si perdu = 1)



;#######################################################################;
;#                           DATA POUR TRON                            #;
;#######################################################################;



    PERDU_TRON_J1        DB "BRAVO rouge"
    PERDU2_TRON_J1        DB "bleu n avait aucune chance !"
    PERDU_TRON_J2        DB "BRAVO bleu"
    PERDU2_TRON_J2        DB "vous avez elimine rouge !"
    JOUEUR_PERDU_TRON    DB 03H             ; SI 0 joueur 1 a perdu sinon 2

    JOUEUR_TAILLE_TRON   DW 08H             ; Taille en pixels du joueur

    JOUEUR1_X_TRON       DW 01CH            ; Position X du joueur
    JOUEUR1_Y_TRON       DW 01AH            ; Position Y du joueur
    VITESSE_JOUEUR1_TRON DW 02H             ; Vitesse de déplacement du joueur (en pixels) lorcequ'on appuie sur une touche

    JOUEUR2_X_TRON       DW 115H            ; Position X du joueur
    JOUEUR2_Y_TRON       DW 09FH            ; Position Y du joueur
    VITESSE_JOUEUR2_TRON DW 02H             ; Vitesse de déplacement du joueur (en pixels) lorcequ'on appuie sur une touche

    TOUCHE_TRON          DB 00H

DSEG        ENDS


CSEG        SEGMENT 'CODE'

    ORG 100H                              ; Offset pour les programmes com

MAIN PROC FAR

    MOV     AX, DSEG
    MOV     DS, AX

    MOV     AH, 00H                       ; Paramètre vidéo
    MOV     AL, 13H                       ; Mode 13h    ----->  320*200 pixels = 40*25 caractères
    INT     10H



    CALL EFF_ECR



                                ;#######################################################################;
                                ;#                            DEBUT DU MENU                            #;
                                ;#######################################################################;



;-----------------------------------------------------------------------------------------------------;
;------------------------------------------- MENU PRINCIPAL ------------------------------------------;
;-----------------------------------------------------------------------------------------------------;


PRINCIPAL:


    MOV     AX, DSEG
    MOV     ES, AX

	CALL    EFF_ECR                         ; Appel de l'effacement écran
    CALL    BIP                             ; Appel du bip sonore

	MOV		BP, offset TITRE_JEU            ; Ecriture du message
	MOV 	AH, 13H                         ; Ecrire dans une chaîne de char
	MOV		BH, 00H                         ; Numéro de page
	MOV		BL, 32H                         ; Attributs ( couleur ...)
	MOV		AL, 00H                         ; Mode écriture
	MOV 	CX, 13                          ; Nombre de char dans le String
	MOV 	DL, 13                          ; Colonne
	MOV		DH, 04                          ; Ligne
	INT		10H                             ; Interruption mode vidéo

    MOV		BP, offset GRIPPE               ; Ecriture du message
	MOV 	AH, 13H                         ; Ecrire dans une chaîne de char
	MOV		BH, 00H                         ; Numéro de page
	MOV		BL, 34H                         ; Attributs ( couleur ...)
	MOV		AL, 00H                         ; Mode écriture
	MOV 	CX, 11                          ; Nombre de char dans le String
	MOV 	DL, 14                          ; Colonne
	MOV		DH, 10                          ; Ligne
	INT		10H                             ; Interruption mode vidéo

	MOV		BP, offset TRON                 ; Ecriture du message
	MOV 	AH, 13H                         ; Ecrire dans une chaîne de char
	MOV		BH, 00H                         ; Numéro de page
	MOV		BL, 35H                         ; Attributs ( couleur ...)
	MOV		AL, 00H                         ; Mode écriture
	MOV 	CX, 06                          ; Nombre de char dans le String
	MOV 	DL, 14                          ; Colonne
	MOV		DH, 13                          ; Ligne
	INT		10H                             ; Interruption mode vidéo

	MOV		BP, offset A_PROPOS             ; Ecriture du message
	MOV 	AH, 13H                         ; Ecrire dans une chaîne de char
	MOV		BH, 00H                         ; Numéro de page
	MOV		BL, 36H                         ; Attributs ( couleur ...)
	MOV		AL, 00H                         ; Mode écriture
	MOV 	CX, 10                          ; Nombre de char dans le String
	MOV 	DL, 14                          ; Colonne
	MOV		DH, 16                          ; Ligne
	INT		10H                             ; Interruption mode vidéo

    MOV		BP, offset QUITTER              ; Ecriture du message
	MOV 	AH, 13H                         ; Ecrire dans une chaîne de char
	MOV		BH, 00H                         ; Numéro de page
	MOV		BL, 37H                         ; Attributs ( couleur ...)
	MOV		AL, 00H                         ; Mode écriture
	MOV 	CX, 09                          ; Nombre de char dans le String
	MOV 	DL, 14                          ; Colonne
	MOV		DH, 20                          ; Ligne
	INT		10H                             ; Interruption mode vidéo



@MENUG:

	MOV		AH, 00H                       ; Récupération de la touche enfoncé si
	INT		16H                           ; Interruption 16
	CMP 	AL, 49                        ; Comparaison avec 49 en ASCII (en décimal)
	JNE 	@PROPOS                       ; Si n'est pas égal comparé la touche suivante
	JMP 	menuGRIPPE                    ; Sinon accéder à la 1ere partie du menu (les jeux)

@PROPOS:

    CMP 	AL, 51
	JNE 	@MENUT
	JMP 	aPROPOS

@MENUT:

    CMP 	AL, 50
	JNE 	@ECHP1
	JMP 	menuTRON

@ECHP1:

    CMP	    AL, 27
	JNE		@ECHPMENU

    MOV     AH, 00H
    INT     21H

@ECHPMENU:

    CMP 	AL, 52
	JNE		@MENUG
    MOV     AH, 4CH
    MOV     AL, 00H
    INT     21H

MENU1:

	JMP PRINCIPAL


;----------------------------------------------------------------------------------------------------;
;------------------------------------------- 1 - LA GRIPPE ------------------------------------------;
;----------------------------------------------------------------------------------------------------;



menuGRIPPE:

	CALL    BIP                         ; Appel du bip sonore
    CALL    EFF_ECR                     ; Appel de l'effacement d'écran

    MOV		BP, offset TXTGRIPPE1       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 30H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 31                      ; Nombre de char dans le String
	MOV 	DL, 05                      ; Colonne
	MOV		DH, 03                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

    MOV		BP, offset TXTGRIPPE2       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 31H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 31                      ; Nombre de char dans le String
	MOV 	DL, 05                      ; Colonne
	MOV		DH, 04                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

    MOV		BP, offset TXTGRIPPE3       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 32H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 31                      ; Nombre de char dans le String
	MOV 	DL, 05                      ; Colonne
	MOV		DH, 05                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

    MOV		BP, offset JOUER_GRIPPE     ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 31H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 07                      ; Nombre de char dans le String
	MOV 	DL, 14                      ; Colonne
	MOV		DH, 10                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset AIDE_GRIPPE      ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 2FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 06                      ; Nombre de char dans le String
	MOV 	DL, 14                      ; Colonne
	MOV		DH, 13                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset PARA_GRIPPE      ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 2EH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 12                      ; Nombre de char dans le String
	MOV 	DL, 14                      ; Colonne
	MOV		DH, 16                      ; Ligne
	INT		10H                         ; Interruption mode vidéo


@DIFFGRP:

	MOV		AH, 00H                     ; Récupération de la touche enfoncé si
	INT		16H                         ; Interruption 16
	CMP 	AL, 49                      ; Comparaison avec 49 en ASCII (en décimal)
	JNE 	@AIDEGRP                    ; Si n'est pas égal comparé la touche suivante
	JMP 	diffGRIPPE                  ; Sinon accéder à la 1ere partie du menu (les jeux)

@AIDEGRP:

    CMP 	AL, 50
	JNE 	@PARAGRP
	JMP 	aideGRIPPE

@PARAGRP:

    CMP 	AL, 51
	JNE 	@ECHPGRP
	JMP 	paraGRIPPE

@ECHPGRP:

	MOV		AH, 00H
	INT		16H
	CMP 	AL, 27
	JNE 	@DIFFGRP
	JMP 	PRINCIPAL

MENU2:

	JMP PRINCIPAL

;------------------------------------------- 1.1 - LA GRIPPE : DIFFICULTE ------------------------------------------;

diffGRIPPE:

	CALL    BIP                         ; Appel du bip sonore
    CALL    EFF_ECR                     ; Appel de l'effacement d'écran

	MOV		BP, offset TITRE_DIFFI      ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 0FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 25                      ; Nombre de char dans le String
	MOV 	DL, 07
                          ; Colonne
	MOV		DH, 04                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

    MOV		BP, offset BENIN            ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 47H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 16                      ; Nombre de char dans le String
	MOV 	DL, 09                      ; Colonne
	MOV		DH, 10                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset VIRUL            ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 43H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 19                      ; Nombre de char dans le String
	MOV 	DL, 09                      ; Colonne
	MOV		DH, 13                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset MORTEL           ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 40H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 20                      ; Nombre de char dans le String
	MOV 	DL, 09                      ; Colonne
	MOV		DH, 16                      ; Ligne
	INT		10H                         ; Interruption mode vidéo


@DIFFBENIN:

	MOV		AH, 00H                     ; Récupération de la touche enfoncé si
	INT		16H                         ; Interruption 16
	CMP 	AL, 49                      ; Comparaison avec 49 en ASCII (en décimal)
	JNE 	@DIFFVIRUL                  ; Si n'est pas égal comparé la touche suivante
	JMP 	MAIN_GRIPPE_FACILE                 ; Sinon accéder à la 1ere partie du menu (les jeux)

@DIFFVIRUL:

    CMP 	AL, 50
	JNE 	@DIFFMORTEL
	JMP 	MAIN_GRIPPE_MOYEN

@DIFFMORTEL:

    CMP 	AL, 51
	JNE 	@ECHPDIFF
	JMP 	MAIN_GRIPPE_DUR

@ECHPDIFF:

	MOV		AH, 00H
	INT		16H
	CMP 	AL, 27
	JNE 	@DIFFBENIN
	JMP 	menuGRIPPE

MENU3:

	JMP PRINCIPAL


;------------------------------------------- 1.2 - LA GRIPPE : AIDE ------------------------------------------;


aideGRIPPE:

	CALL    BIP                         ; Appel du bip sonore
    CALL    EFF_ECR                     ; Appel de l'effacement d'écran

	MOV		BP, offset AIDEGRIPPE0       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 32H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 13                      ; Nombre de char dans le String
	MOV 	DL, 12                      ; Colonne
	MOV		DH, 04                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

    MOV		BP, offset AIDEGRIPPE1     ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 34H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 16                      ; Nombre de char dans le String
	MOV 	DL, 16                      ; Colonne
	MOV		DH, 10                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset AIDEGRIPPE2        ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 35H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 07                      ; Nombre de char dans le String
	MOV 	DL, 14                      ; Colonne
	MOV		DH, 13                      ; Ligne
	INT		10H                         ; Interruption mode vidéo


@ECHPAIDEGRP:

	MOV		AH, 00H
	INT		16H
	CMP 	AL, 27
	JNE 	@ECHPAIDEGRP
	JMP 	menuGRIPPE

MENU4:

	JMP PRINCIPAL


;------------------------------------------- 1.3 - LA GRIPPE : PARAMETRES ------------------------------------------;


paraGRIPPE:

	CALL    BIP                         ; Appel du bip sonore
    CALL    EFF_ECR                     ; Appel de l'effacement d'écran

	MOV		BP, offset PARAGRIPPE0       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 32H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 04                      ; Nombre de char dans le String
	MOV 	DL, 12                      ; Colonne
	MOV		DH, 04                      ; Ligne
	INT		10H                         ; Interruption mode vidéo


@ECHPPARAGRP:

	MOV		AH, 00H
	INT		16H
	CMP 	AL, 27
	JNE 	@ECHPPARAGRP
	JMP 	menuGRIPPE

MENU5:

	JMP PRINCIPAL





;-----------------------------------------------------------------------------------------------;
;------------------------------------------- 2 - TRON ------------------------------------------;
;-----------------------------------------------------------------------------------------------;



menuTRON:

	CALL    BIP                         ; Appel du bip sonore
    CALL    EFF_ECR                     ; Appel de l'effacement d'écran

	MOV		BP, offset TXTRON0      ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 20H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 15                      ; Nombre de char dans le String
	MOV 	DL, 12                      ; Colonne
	MOV		DH, 03
                          ; Ligne
	INT		10H                         ; Interruption mode vidéo

    MOV		BP, offset TXTRON1       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 21H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 15                      ; Nombre de char dans le String
	MOV 	DL, 12                      ; Colonne
	MOV		DH, 04                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

    MOV		BP, offset TXTRON2       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 22H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 15                      ; Nombre de char dans le String
	MOV 	DL, 12                      ; Colonne
	MOV		DH, 05                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

    MOV		BP, offset JOUER_TRON     ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 23H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 07                      ; Nombre de char dans le String
	MOV 	DL, 14                      ; Colonne
	MOV		DH, 10                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset AIDE_TRON        ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 26H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 06                      ; Nombre de char dans le String
	MOV 	DL, 14                      ; Colonne
	MOV		DH, 13                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset PARA_TRON        ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 27H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 12                      ; Nombre de char dans le String
	MOV 	DL, 14                      ; Colonne
	MOV		DH, 16                      ; Ligne
	INT		10H                         ; Interruption mode vidéo


@JOUERTRON:

	MOV		AH, 00H                     ; Récupération de la touche enfoncé si
	INT		16H                         ; Interruption 16
	CMP 	AL, 49                      ; Comparaison avec 49 en ASCII (en décimal)
	JNE 	@AIDETRON                   ; Si n'est pas égal comparé la touche suivante
	JMP 	MAIN_TRON                    ; Sinon accéder à la 1ere partie du menu (les jeux)

@AIDETRON:

    CMP 	AL, 50
	JNE 	@PARATRON
	JMP 	aideTRON

@PARATRON:

    CMP 	AL, 51
	JNE 	@ECHPTRON
	JMP 	paraTRON

@ECHPTRON:

	MOV		AH, 00H
	INT		16H
	CMP 	AL, 27
	JNE 	@JOUERTRON
	JMP 	PRINCIPAL

MENU6:

	JMP PRINCIPAL


;------------------------------------------- 2.2 - TRON : AIDE ------------------------------------------;


aideTRON:

	CALL    BIP                         ; Appel du bip sonore
    CALL    EFF_ECR                     ; Appel de l'effacement d'écran

	MOV		BP, offset AIDETRON0       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 32H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 11                      ; Nombre de char dans le String
	MOV 	DL, 12                      ; Colonne
	MOV		DH, 04                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

    MOV		BP, offset AIDETRON1     ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 34H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 10H                      ; Nombre de char dans le String
	MOV 	DL, 10H                      ; Colonne
	MOV		DH, 0AH                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset AIDETRON2        ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 35H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 18                      ; Nombre de char dans le String
	MOV 	DL, 14                      ; Colonne
	MOV		DH, 13                      ; Ligne
	INT		10H                         ; Interruption mode vidéo


@ECHPAIDETRON:

	MOV		AH, 00H
	INT		16H
	CMP 	AL, 27
	JNE 	@ECHPAIDETRON
	JMP 	menuTRON

MENU7:

	JMP PRINCIPAL


;------------------------------------------- 2.3 - TRON : PARAMETRES ------------------------------------------;


paraTRON:

	CALL    BIP                         ; Appel du bip sonore
    CALL    EFF_ECR                     ; Appel de l'effacement d'écran


        MOV		BP, offset TEST1       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 09H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 26                      ; Nombre de char dans le String
	MOV 	DL, 01                      ; Colonne
	MOV		DH, 02                      ; Ligne
	INT		10H                         ; Interruption mode vidéo
    	MOV		BP, offset TEST2       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 09H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 26                     ; Nombre de char dans le String
	MOV 	DL, 01                      ; Colonne
	MOV		DH, 03                      ; Ligne
	INT		10H                         ; Interruption mode vidéo
        	MOV		BP, offset TEST3       ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 09H                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 26                      ; Nombre de char dans le String
	MOV 	DL, 01                      ; Colonne
	MOV		DH, 04                      ; Ligne
	INT		10H                         ; Interruption mode vidéo





@ECHPPARATRON:

	MOV		AH, 00H
	INT		16H
	CMP 	AL, 27
	JNE 	@ECHPPARATRON
	JMP 	menuTRON

MENU8:

	JMP PRINCIPAL






;--------------------------------------------------------------------------------------------------;
;------------------------------------------- 3- A PROPOS ------------------------------------------;
;--------------------------------------------------------------------------------------------------;



aPROPOS:

	CALL    BIP                         ; Appel du bip sonore
    CALL    EFF_ECR                     ; Appel de l'effacement d'écran

    MOV		BP, OFFSET A_PROP0			; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 0FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H 					; Mode écriture
	MOV 	CX, 10						; Nombre de char dans le String
	MOV 	DL, 15						; Colonne
	MOV		DH, 06						; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset A_PROP1          ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 0FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 16                      ; Nombre de char dans le String
	MOV 	DL, 12                      ; Colonne
	MOV		DH, 11                      ; Ligne
	INT		10H

	MOV		BP, offset A_PROP2          ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 0FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 13                      ; Nombre de char dans le String
	MOV 	DL, 13                      ; Colonne
	MOV		DH, 13                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset A_PROP3          ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 0FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 10                      ; Nombre de char dans le String
	MOV 	DL, 02                     ; Colonne
	MOV		DH, 20                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset A_PROP4          ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 0FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 10                      ; Nombre de char dans le String
	MOV 	DL, 02                      ; Colonne
	MOV		DH, 22                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset A_PROP5          ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 0FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 17                      ; Nombre de char dans le String
	MOV 	DL, 21                      ; Colonne
	MOV		DH, 22                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset A_PROP6          ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 0FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 08                      ; Nombre de char dans le String
	MOV 	DL, 30                      ; Colonne
	MOV		DH, 20                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

	MOV		BP, offset A_PROP7          ; Ecriture du message
	MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
	MOV		BH, 00H                     ; Numéro de page
	MOV		BL, 0FH                     ; Attributs ( couleur ...)
	MOV		AL, 00H                     ; Mode écriture
	MOV 	CX, 11                      ; Nombre de char dans le String
	MOV 	DL, 27                      ; Colonne
	MOV		DH, 23                      ; Ligne
	INT		10H                         ; Interruption mode vidéo

@ECHPAPROPOS:

	MOV		AH, 00H
	INT		16H
	CMP 	AL, 27
	JNE 	@ECHPPARATRON
	JMP 	PRINCIPAL

MENU9:

	JMP PRINCIPAL
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------
;-----------------------------------;-----------------------------------

                                ;#######################################################################;
                                ;#                            FIN DU MENU                              #;
                                ;#######################################################################;



    MOV     AH, 2CH         ; Obtention de l'heure
    INT     21H
    MOV     STIME, DH       ; DH pour avoir les secondes

    MAIN_GRIPPE_FACILE:

        CALL GESTION_SPAWN_ENNEMIS

        MAIN_BOUCLE_GRIPPE_FACILE :

            CALL    VERIF_TPS

            CALL    EFF_ECR                     ; Appel de la procedure d'effacage d'écran

            CALL    MVT_JOUEUR
            CALL    DIFFI_VITESSE               ; Appel de la procedure qui augmente la difficulté au cours du tps

            CALL    MOUVEMENT_ENNEMIS           ; Appel de la procédure de mouvement des ENNEMIS
            CALL    MOUVEMENT_ENNEMIS1          ; Appel de la procédure de mouvement des ENNEMIS


            CALL    CREER_ENNEMIS               ; Appel de la procédure de création des ENNEMIS
            CALL    CREER_ENNEMIS1              ; Appel de la procédure de création des ENNEMIS


            CALL    CREER_JOUEUR_GRIPPE         ; Appel de la procédure de création du joueur
            CALL    MVT_JOUEUR                  ; Appel de la procédure CLAVIER gérant le déplacements du joueur avec les flèches
            CALL    AFFICHE_SCORE

            CALL    VERIF_J                     ; Appel de la procédure qui vérifie les conditions d'échec


            CMP     PERDU, 1
            JE      QUITTE_GRIPPE

            JMP     MAIN_BOUCLE_GRIPPE_FACILE

    MAIN_GRIPPE_MOYEN:

        CALL GESTION_SPAWN_ENNEMIS

        MAIN_BOUCLE_GRIPPE_MOYEN :

            CALL VERIF_TPS

            CALL    EFF_ECR                     ; Appel de la procedure d'effacage d'écran

            CALL    MVT_JOUEUR
            CALL    DIFFI_VITESSE               ; Appel de la procedure qui augmente la difficulté au cours du tps

            CALL    MOUVEMENT_ENNEMIS           ; Appel de la procédure de mouvement des ENNEMIS
            CALL    MOUVEMENT_ENNEMIS1          ; Appel de la procédure de mouvement des ENNEMIS
            CALL    MOUVEMENT_ENNEMIS2          ; Appel de la procédure de mouvement des ENNEMIS

            CALL    CREER_ENNEMIS               ; Appel de la procédure de création des ENNEMIS
            CALL    CREER_ENNEMIS1              ; Appel de la procédure de création des ENNEMIS
            CALL    CREER_ENNEMIS2              ; Appel de la procédure de création des ENNEMIS

            CALL    CREER_JOUEUR_GRIPPE         ; Appel de la procédure de création du joueur
            CALL    MVT_JOUEUR                  ; Appel de la procédure CLAVIER gérant le déplacements du joueur avec les flèches
            CALL    AFFICHE_SCORE

            CALL    VERIF_J                     ; Appel de la procédure qui vérifie les conditions d'échec


            CMP     PERDU, 1
            JE      QUITTE_GRIPPE

            JMP     MAIN_BOUCLE_GRIPPE_MOYEN

    MAIN_GRIPPE_DUR:

        CALL GESTION_SPAWN_ENNEMIS

        MAIN_BOUCLE_GRIPPE_DUR :

            CALL VERIF_TPS

            CALL    EFF_ECR                     ; Appel de la procedure d'effacage d'écran

            CALL    MVT_JOUEUR
            CALL    DIFFI_VITESSE               ; Appel de la procedure qui augmente la difficulté au cours du tps

            CALL    MOUVEMENT_ENNEMIS           ; Appel de la procédure de mouvement des ENNEMIS
            CALL    MOUVEMENT_ENNEMIS1          ; Appel de la procédure de mouvement des ENNEMIS
            CALL    MOUVEMENT_ENNEMIS2          ; Appel de la procédure de mouvement des ENNEMIS
            CALL    MOUVEMENT_ENNEMIS3          ; Appel de la procédure de mouvement des ENNEMIS

            CALL    CREER_ENNEMIS               ; Appel de la procédure de création des ENNEMIS
            CALL    CREER_ENNEMIS1              ; Appel de la procédure de création des ENNEMIS
            CALL    CREER_ENNEMIS2              ; Appel de la procédure de création des ENNEMIS
            CALL    CREER_ENNEMIS3              ; Appel de la procédure de création des ENNEMIS

            CALL    CREER_JOUEUR_GRIPPE         ; Appel de la procédure de création du joueur
            CALL    MVT_JOUEUR                  ; Appel de la procédure CLAVIER gérant le déplacements du joueur avec les flèches
            CALL    AFFICHE_SCORE

            CALL    VERIF_J                     ; Appel de la procédure qui vérifie les conditions d'échec


            CMP     PERDU, 1
            JE      QUITTE_GRIPPE

            JMP     MAIN_BOUCLE_GRIPPE_DUR


    QUITTE_GRIPPE :

        CALL    DEFAITE



    MAIN_TRON :

        CALL EFF_ECR

        MAIN_BOUCLE_TRON :

            CALL    CREER_JOUEUR1_TRON      ; Appel de la procédure de création du joueur
            CALL    CREER_JOUEUR2_TRON      ; Appel de la procédure de création du joueur
            CALL    CLAVIER_TRON            ; Appel de la procédure CLAVIER gérant le déplacements du joueur avec les flèches
            CALL    VERIF_TRON              ; Appel de la procédure vérifiant les conditions d'échec des 2 joueurs

            CMP     PERDU, 1
            JE      QUITTE_TRON

            JMP     MAIN_BOUCLE_TRON

        QUITTE_TRON :

            CALL DEFAITE_TRON

            RECOMENCER_TOUCHE :

                CALL REINIT_VARI_TRON

                MOV AH, 00H
                INT 16H

                CMP AL, 6DH
                JE PRINCIPAL
                CMP AL, 72H
                JE MAIN_TRON
                CMP AL, 71H
                JNE RECOMENCER_TOUCHE
                MOV AH, 00H
                INT 21H

    RET


MAIN    ENDP



                                ;#######################################################################;
                                ;#                            FIN DU MAIN                              #;
                                ;#######################################################################;



BIP PROC
    MOV     AL, 182                         ; Préparer le h-p pour la
    OUT     43H, AL                         ; note
    MOV     AX, TON                         ; Fréquence en décimal de la not
    OUT     42H, AL                         ; Sortie bit de poids faible
    MOV     AL, AH                          ; Sortie bit de poids fort
    OUT     42H, AL
    IN      AL, 61h                         ; Activer la note (reçevoir la valeur duport 61h)
    OR      AL, 3H                          ; Définir bits 1 et 0
    OUT     61h, AL                         ; Envoyer nouvelle valeur
    MOV     BX, 4                           ; Pause le temps de la note

    .pause1:

        MOV    CX, 32222

    .pause2:

        DEC    CX
        JNE    .pause2
        DEC    BX
        JNE    .pause1
        IN     AL, 61h                      ; Désactive la note(reçoit la valeur du port 61)
        AND    AL, 11111100b                ; Reset des bits 1 et 0.
        OUT    61H, AL                      ; Envoyer nouvelle valeur.

BIP ENDP

VERIF_TPS PROC

    VERIFICATION_TPS :

        MOV     AH, 2CH                    ; Prendre le temps du systeme
        INT     21H                        ; CH = heure CL = minute DH = seconde DL = 1/100 secondes

        CMP     DL, TEMPS_ALT              ; le temps actuel est-il égal au précédent ? (TEMPS_ALT)
        JE      VERIFICATION_TPS           ; Si c'est le même, re-vérifier, sinon, passer aux étapes suivantes

        MOV     TEMPS_ALT, DL              ; Mise-à-jour de TEMPS_ALT au temps actuel

VERIF_TPS ENDP



MVT_JOUEUR PROC

    MOV     AH, 01H                         ; Recevoir l'état du buffer du clavier
    INT     16H                             ; Interruption d'obtention de touche du clavier
    JNZ     TOUCHE_DETECTER

    RET                                     ; Return rien si aucune touche n'est presser

    TOUCHE_DETECTER:

    MOV     AH, 10H
    INT     16H                             ; Interruption d'obtention de touche du clavier

    CMP     AL, 1BH                         ; Si touche "échap", alors sauter Le déplacement du joueur
    JE      ECHAP

    CMP     AL, 7AH                         ; 7AH corresponds à "z" sur le clavier en Hex
    JNE SUITE1
    MOV DX, 03H
    CMP JOUEUR_Y, DX
    JNL      JOUEUR_HAUT                     ; Aller à JOUEUR_HAUT

    SUITE1 :
        CMP     AL, 73H                         ; 73H corresponds à "s" sur le clavier en Hex
        JNE SUITE2
        MOV DX, JOUEUR_Y
        ADD DX, JOUEUR_TAILLE
        ADD DX, 03H
        CMP DX, LONGEUR_ECRAN
        JL      JOUEUR_BAS                      ; Aller à JOUEUR_BAS

    SUITE2 :
        CMP     AL, 71H                         ; 71H corresponds à "q" sur le clavier en Hex
        JNE SUITE3
        MOV DX, JOUEUR_X
        CMP DX, 05H
        JNL      JOUEUR_GAUCHE                   ; Aller à JOUEUR_GAUCHE

    SUITE3 :
        CMP     AL, 64H                         ; 64H corresponds à "d" sur le clavier en Hex
        JNE SUITE4
        MOV DX, JOUEUR_X
        ADD DX, JOUEUR_TAILLE
        ADD DX, 03H
        CMP DX, LARGEUR_ECRAN
        JL      JOUEUR_DROITE                   ; Aller à JOUEUR_DROITE

    SUITE4 :
        RET

    ; Pour chaque déplacement du joueur ci-dessous, on récupère la position du joueur
    ; en x ou y et on modifie celle-ci par un déplacement de VITESSE_JOUEUR pixels

    JOUEUR_HAUT:

        MOV     BX, JOUEUR_Y
        SUB     BX, VITESSE_JOUEUR
        MOV     JOUEUR_Y, BX                ; Modification de y une fois la soustraction du pas de VITTESSE_JOUEUR faite

    RET

    JOUEUR_BAS:

        MOV     BX, JOUEUR_Y
        ADD     BX, VITESSE_JOUEUR
        MOV     JOUEUR_Y, BX

    RET

    JOUEUR_GAUCHE:

        MOV     BX, JOUEUR_X
        SUB     BX, VITESSE_JOUEUR
        MOV     JOUEUR_X, BX

    RET

    JOUEUR_DROITE:

        MOV     BX, JOUEUR_X
        ADD     BX, VITESSE_JOUEUR
        MOV     JOUEUR_X, BX

    RET

    ECHAP:

        MOV     AH, 00H
        INT     21H
                                            ; Interruption mettant fin au programme
    RET

MVT_JOUEUR ENDP

CALCUL_SCORE PROC

    MOV     AH, 2CH                         ; Obtention de l'heure
    INT     21H
    CMP     DH, STIME                       ; Récupère les secondes de l'heure
    JE      FIN_CALC_SCORE                  ; Si les secondes obtenu sont les même que celles sauvegardés
                                            ; alors ne pas incrémenter le score
    MOV     STIME, DH                       ; Sinon écrire les secondes sur celle sauvegardés
    CMP     SCORE_UNITE, 39H                ; Compare l'unité du score par le code ASCII 9 pour
    JE      RETENUE_DIZAINE                 ; voir si il y a besoin d'une retenu
    INC     SCORE_UNITE                     ; Incrémente l'U du score

    RET

    RETENUE_DIZAINE :

        MOV     SCORE_UNITE, 30H            ; Si retenue mettre l'U à 0
        CMP     SCORE_DIZAINE, 39H          ; Compare la dizaine avec 9 en ASCII pour
        JE      RETENUE_CENTAINE            ; voir si il y a besoin d'une retenue
        INC     SCORE_DIZAINE               ; Incrémente la dizaine du score

    RET

    RETENUE_CENTAINE :

        MOV SCORE_DIZAINE, 30H              ; Si retenu mettre la dizaine à 0
        INC SCORE_CENTAINE                  ; Incrémente la centaine

    FIN_CALC_SCORE :

    RET

CALCUL_SCORE ENDP

AFFICHE_SCORE PROC

    MOV     AL, 01H                         ; Mode d'écriture chaine de str
	MOV     BH, 00H                         ; Page 0
	MOV     BL, 0FH                         ; Couleur
	MOV     CX,  SCORE_FIN - OFFSET SCORE   ; Calcul la taille du message
	MOV     DL, 1FH                         ; Axe x du msg
	MOV     DH, 01H                         ; Axe y du msg
	PUSH    CS                              ; Quitte le segment code
	POP     ES                              ; Pour aller à L'extra segment
	MOV     BP, OFFSET SCORE                ; Récuppère l'@ de score
	MOV     AH, 13H                         ; Fonction qui affiche le msg
	INT     10H
    JMP     SCORE_FIN

    SCORE DB " Score :"
    SCORE_FIN :

        CALL CALCUL_SCORE       ; Appel de la procédure qui calcul le score

        MOV     BH, 00H       				; Page 0 défaut pour tout les affichages
        MOV     CX, 01H       				; Nombre de fois à afficher le caractère
                                            ; (Le même pour tous)

        MOV     AH, 02H       				; Placement du "curseur", ou le texte sera mis
        MOV     DL, 27H       				; Colonnes
        MOV     DH, 01H       			    ; Lignes
        INT     10H

        MOV     AH, 09H       				; Fonction qui écrit 1 seul caractère
        MOV     BL, 0FH     				; Couleur
        MOV     AL, SCORE_UNITE  			; Caractère à imprimer
        INT     10H

        MOV     AH, 02H       				; Placement du "curseur", ou le texte sera mis
        MOV     DL, 26H       				; Colonnes
        MOV     DH, 01H       			    ; Lignes
        INT     10H

        MOV     AH, 09H       				; Fonction qui écrit 1 seul caractère
        MOV     BL, 0FH     				; Couleur
        MOV     AL, SCORE_DIZAINE  			; Caractère à imprimer
        INT     10H

        MOV     AH, 02H       				; Placement du "curseur", ou le texte sera mis
        MOV     DL, 25H       				; Colonnes
        MOV     DH, 01H       			    ; Lignes
        INT     10H

        MOV     AH, 09H       				; Fonction qui écrit 1 seul caractère
        MOV     BL, 0FH     				; Couleur
        MOV     AL, SCORE_CENTAINE  		; Caractère à imprimer
        INT     10H

        RET

AFFICHE_SCORE ENDP

GESTION_SPAWN_ENNEMIS PROC

    MOV AH, 2CH
    XOR AL, AL
    INT 21H
    CALL SPAWN_ENNEMIS
    MOV AX, TEMP_X
    MOV BX, TEMP_Y
    MOV ENNEMIS_X, AX
    MOV ENNEMIS_Y, BX


    XOR DH, DH
    SUB DX, CX
    CMP DX, 00h
    JNL SUITE5
    NEG DX
    SUITE5 :
    CALL SPAWN_ENNEMIS
    MOV AX, TEMP_X
    MOV BX, TEMP_Y
    MOV ENNEMIS1_X, AX
    MOV ENNEMIS1_Y, BX

    MOV AH, 2AH
    XOR AL, AL
    INT 21H
    XOR DH, DH
    ADD DX, CX
    CALL SPAWN_ENNEMIS
    MOV AX, TEMP_X
    MOV BX, TEMP_Y
    MOV ENNEMIS2_X, AX
    MOV ENNEMIS2_Y, BX

    CALL SPAWN_ENNEMIS
    MOV AX, TEMP_X
    MOV BX, TEMP_Y
    MOV ENNEMIS3_X, AX
    MOV ENNEMIS3_Y, BX

    RET

GESTION_SPAWN_ENNEMIS ENDP

SPAWN_ENNEMIS PROC

    GENE_X :
        MOV AX, DX
        XOR DX, DX
        MOV CX, LARGEUR_ECRAN
        SUB CX, ENNEMIS_TAILLE
        SUB CX, LIMITE_ECRAN
        DIV CX
        MOV TEMP_X, DX
        CMP DX, LIMITE_ECRAN
        JL GENE_X

        CMP TEMP_X, 0064H
        JL GENE_Y
        CMP TEMP_X, 00DCH
        JNL GENE_Y

    GENE_Y2 :

        MOV AH, 2CH
        XOR AL, AL
        INT 21H
        MOV AX, DX
        XOR DX, DX
        MOV CX, LONGEUR_ECRAN
        SUB CX, LIMITE_ECRAN
        SUB CX, ENNEMIS_TAILLE
        MOV CX, LONGEUR_ECRAN
        DIV CX
        CMP DX, LIMITE_ECRAN
        JL GENE_Y2
        CMP DX, 003CH
        JNL GENE_Y3
        MOV TEMP_Y, DX
        RET

    GENE_Y3 :

        CMP DX, 00C8H
        JL GENE_Y2
        MOV TEMP_Y, DX
        RET

    GENE_Y :

        MOV AH, 2CH
        XOR AL, AL
        INT 21H
        MOV AX, DX
        XOR DX, DX
        MOV CX, LONGEUR_ECRAN
        SUB CX, LIMITE_ECRAN
        SUB CX, ENNEMIS_TAILLE
        DIV CX
        CMP DX, LIMITE_ECRAN
        JL GENE_Y
        MOV TEMP_Y, DX

    RET

SPAWN_ENNEMIS ENDP

DIFFI_VITESSE PROC

    MOV AH, SCORE_DIZAINE
    CMP AH, K
    JNE MODIF_V
    RET

    MODIF_V :

        MOV BX, VITESSE_ENNEMIS3_X
        MOV CX, VITESSE_ENNEMIS3_Y
        CALL MODIF_VITESSE
        MOV VITESSE_ENNEMIS3_X, BX
        MOV VITESSE_ENNEMIS3_Y, CX

        MOV BX, VITESSE_ENNEMIS2_X
        MOV CX, VITESSE_ENNEMIS2_Y
        CALL MODIF_VITESSE
        MOV VITESSE_ENNEMIS2_X, BX
        MOV VITESSE_ENNEMIS2_Y, CX

        MOV BX, VITESSE_ENNEMIS1_X
        MOV CX, VITESSE_ENNEMIS1_Y
        CALL MODIF_VITESSE
        MOV VITESSE_ENNEMIS1_X, BX
        MOV VITESSE_ENNEMIS1_Y, CX

        MOV BX, VITESSE_ENNEMIS_X
        MOV CX, VITESSE_ENNEMIS_Y
        CALL MODIF_VITESSE
        MOV VITESSE_ENNEMIS_X, BX
        MOV VITESSE_ENNEMIS_Y, CX

        INC K

    RET

DIFFI_VITESSE ENDP

MODIF_VITESSE PROC

    CMP BX, 00H
    JL NEGX1
    ADD BX, V_DIFF
    JMP MODIF_V_Y1
    NEGX1 :
        SUB BX, V_DIFF
    MODIF_V_Y1 :
        CMP CX, 00H
        JL NEGY1
        ADD CX, V_DIFF
        RET
        NEGY1 :
            SUB CX, V_DIFF
    RET

MODIF_VITESSE ENDP

MOUVEMENT_ENNEMIS PROC

    MOV     AX, VITESSE_ENNEMIS_X
    ADD     ENNEMIS_X, AX                 ; Déplace horizontalement les ENNEMIS

    MOV     AX, LIMITE_ECRAN
    CMP     ENNEMIS_X, AX
    JL      VITESSE_NEG_ENNEMIS_X           ; ENNEMIS_X < 0 (oui = collision)

    MOV     AX, LARGEUR_ECRAN
    SUB     AX, ENNEMIS_TAILLE
    SUB     AX, LIMITE_ECRAN
    CMP     ENNEMIS_X, AX                 ; ENNEMIS_X > LARGEUR_ECRAN - ENNEMIS_TAILLE - LIMITE_ECRAN(oui = collision)
    JG      VITESSE_NEG_ENNEMIS_X


    MOV     AX, VITESSE_ENNEMIS_Y
    ADD     ENNEMIS_Y, AX                 ; Déplace verticalement le ENNEMIS

    MOV     AX, LIMITE_ECRAN
    CMP     ENNEMIS_Y, AX                 ; ENNEMIS_Y < 0 (oui = collision)
    JL      VITESSE_NEG_ENNEMIS_Y

    MOV     AX, LONGEUR_ECRAN
    SUB     AX, ENNEMIS_TAILLE
    SUB     AX, LIMITE_ECRAN
    CMP     ENNEMIS_Y, AX                 ; ENNEMIS_Y > LONGEUR_ECRAN - ENNEMIS_TAILLE - LIMITE_ECRAN (oui = collision)
    JG      VITESSE_NEG_ENNEMIS_Y

    RET

    VITESSE_NEG_ENNEMIS_X :

        NEG     VITESSE_ENNEMIS_X             ; VITESSE_ENNEMIS_X devient - VITESSE_ENNEMIS_X

    RET

    VITESSE_NEG_ENNEMIS_Y :

        NEG     VITESSE_ENNEMIS_Y             ; VITESSE_ENNEMIS_Y devient - VITESSE_ENNEMIS_Y

    RET

MOUVEMENT_ENNEMIS ENDP

CREER_ENNEMIS PROC

    MOV     CX, ENNEMIS_X
    MOV     DX, ENNEMIS_Y

    CREER_ENNEMIS_HORIZONTAL :

        MOV     AX, 0C04H
        MOV     BH, 00H
        INT     10H

        INC     CX
        MOV     AX, CX
        SUB     AX, ENNEMIS_X
        CMP     AX, ENNEMIS_TAILLE
        JNG     CREER_ENNEMIS_HORIZONTAL

        MOV     CX, ENNEMIS_X

        INC     DX

        MOV     AX, DX
        SUB     AX, ENNEMIS_Y
        CMP     AX, ENNEMIS_TAILLE
        JNG     CREER_ENNEMIS_HORIZONTAL

    RET

CREER_ENNEMIS ENDP

MOUVEMENT_ENNEMIS1 PROC

    MOV     AX, VITESSE_ENNEMIS1_X
    ADD     ENNEMIS1_X, AX                 ; Déplace horizontalement les ENNEMIS

    MOV     AX, LIMITE_ECRAN
    CMP     ENNEMIS1_X, AX
    JL      VITESSE_NEG_ENNEMIS1_X           ; ENNEMIS_X < 0 (oui = collision)

    MOV     AX, LARGEUR_ECRAN
    SUB     AX, ENNEMIS1_TAILLE
    SUB     AX, LIMITE_ECRAN
    CMP     ENNEMIS1_X, AX                 ; ENNEMIS_X > LARGEUR_ECRAN - ENNEMIS_TAILLE - LIMITE_ECRAN(oui = collision)
    JG      VITESSE_NEG_ENNEMIS1_X


    MOV     AX, VITESSE_ENNEMIS1_Y
    ADD     ENNEMIS1_Y, AX                 ; Déplace verticalement le ENNEMIS

    MOV     AX, LIMITE_ECRAN
    CMP     ENNEMIS1_Y, AX                 ; ENNEMIS_Y < 0 (oui = collision)
    JL      VITESSE_NEG_ENNEMIS1_Y

    MOV     AX, LONGEUR_ECRAN
    SUB     AX,  ENNEMIS1_TAILLE
    SUB     AX, LIMITE_ECRAN
    CMP     ENNEMIS1_Y, AX                 ; ENNEMIS_Y > LONGEUR_ECRAN - ENNEMIS_TAILLE - LIMITE_ECRAN (oui = collision)
    JG      VITESSE_NEG_ENNEMIS1_Y

    RET

    VITESSE_NEG_ENNEMIS1_X :

        NEG     VITESSE_ENNEMIS1_X             ; VITESSE_ENNEMIS_X devient - VITESSE_ENNEMIS_X

    RET

    VITESSE_NEG_ENNEMIS1_Y :

        NEG     VITESSE_ENNEMIS1_Y             ; VITESSE_ENNEMIS_Y devient - VITESSE_ENNEMIS_Y

    RET

MOUVEMENT_ENNEMIS1 ENDP

CREER_ENNEMIS1 PROC

    MOV     CX, ENNEMIS1_X
    MOV     DX, ENNEMIS1_Y

    CREER_ENNEMIS1_HORIZONTAL :

        MOV     AX,0C04H
        MOV     BH,0
        INT     10H

        INC     CX
        MOV     AX, CX
        SUB     AX, ENNEMIS1_X
        CMP     AX, ENNEMIS1_TAILLE
        JNG     CREER_ENNEMIS1_HORIZONTAL

        MOV     CX, ENNEMIS1_X

        INC     DX

        MOV     AX,DX
        SUB     AX, ENNEMIS1_Y
        CMP     AX, ENNEMIS1_TAILLE
        JNG     CREER_ENNEMIS1_HORIZONTAL

    RET

CREER_ENNEMIS1 ENDP

MOUVEMENT_ENNEMIS2 PROC

    MOV     AX, VITESSE_ENNEMIS2_X
    ADD     ENNEMIS2_X, AX                 ; Déplace horizontalement les ENNEMIS

    MOV     AX, LIMITE_ECRAN
    CMP     ENNEMIS2_X, AX
    JL      VITESSE_NEG_ENNEMIS2_X           ; ENNEMIS_X < 0 (oui = collision)

    MOV     AX, LARGEUR_ECRAN
    SUB     AX, ENNEMIS2_TAILLE
    SUB     AX, LIMITE_ECRAN
    CMP     ENNEMIS2_X, AX                 ; ENNEMIS_X > LARGEUR_ECRAN - ENNEMIS_TAILLE - LIMITE_ECRAN(oui = collision)
    JG      VITESSE_NEG_ENNEMIS2_X


    MOV     AX, VITESSE_ENNEMIS2_Y
    ADD     ENNEMIS2_Y, AX                 ; Déplace verticalement le ENNEMIS

    MOV     AX, LIMITE_ECRAN
    CMP     ENNEMIS2_Y, AX                 ; ENNEMIS_Y < 0 (oui = collision)
    JL      VITESSE_NEG_ENNEMIS2_Y

    MOV     AX, LONGEUR_ECRAN
    SUB     AX,  ENNEMIS2_TAILLE
    SUB     AX, LIMITE_ECRAN
    CMP     ENNEMIS2_Y, AX                 ; ENNEMIS_Y > LONGEUR_ECRAN - ENNEMIS_TAILLE - LIMITE_ECRAN (oui = collision)
    JG      VITESSE_NEG_ENNEMIS2_Y

    RET

    VITESSE_NEG_ENNEMIS2_X :

        NEG     VITESSE_ENNEMIS2_X             ; VITESSE_ENNEMIS_X devient - VITESSE_ENNEMIS_X

    RET

    VITESSE_NEG_ENNEMIS2_Y :

        NEG     VITESSE_ENNEMIS2_Y             ; VITESSE_ENNEMIS_Y devient - VITESSE_ENNEMIS_Y

    RET

MOUVEMENT_ENNEMIS2 ENDP

CREER_ENNEMIS2 PROC

    MOV     CX, ENNEMIS2_X
    MOV     DX, ENNEMIS2_Y

    CREER_ENNEMIS2_HORIZONTAL :

        MOV     AX,0C04H
        MOV     BH,0
        INT     10H

        INC     CX
        MOV     AX, CX
        SUB     AX, ENNEMIS2_X
        CMP     AX, ENNEMIS2_TAILLE
        JNG     CREER_ENNEMIS2_HORIZONTAL

        MOV     CX, ENNEMIS2_X

        INC     DX

        MOV     AX,DX
        SUB     AX, ENNEMIS2_Y
        CMP     AX, ENNEMIS2_TAILLE
        JNG     CREER_ENNEMIS2_HORIZONTAL

    RET

CREER_ENNEMIS2 ENDP

MOUVEMENT_ENNEMIS3 PROC

    MOV     AX, VITESSE_ENNEMIS3_X
    ADD     ENNEMIS3_X, AX                 ; Déplace horizontalement les ENNEMIS

    MOV     AX, LIMITE_ECRAN
    CMP     ENNEMIS3_X, AX
    JL      VITESSE_NEG_ENNEMIS3_X           ; ENNEMIS_X < 0 (oui = collision)

    MOV     AX, LARGEUR_ECRAN
    SUB     AX, ENNEMIS3_TAILLE
    SUB     AX, LIMITE_ECRAN
    CMP     ENNEMIS3_X, AX                 ; ENNEMIS_X > LARGEUR_ECRAN - ENNEMIS_TAILLE - LIMITE_ECRAN(oui = collision)
    JG      VITESSE_NEG_ENNEMIS3_X


    MOV     AX, VITESSE_ENNEMIS3_Y
    ADD     ENNEMIS3_Y, AX                 ; Déplace verticalement le ENNEMIS

    MOV     AX, LIMITE_ECRAN
    CMP     ENNEMIS3_Y, AX                 ; ENNEMIS_Y < 0 (oui = collision)
    JL      VITESSE_NEG_ENNEMIS3_Y

    MOV     AX, LONGEUR_ECRAN
    SUB     AX,  ENNEMIS3_TAILLE
    SUB     AX, LIMITE_ECRAN
    CMP     ENNEMIS3_Y, AX                 ; ENNEMIS_Y > LONGEUR_ECRAN - ENNEMIS_TAILLE - LIMITE_ECRAN (oui = collision)
    JG      VITESSE_NEG_ENNEMIS3_Y

    RET

    VITESSE_NEG_ENNEMIS3_X :

        NEG     VITESSE_ENNEMIS3_X             ; VITESSE_ENNEMIS_X devient - VITESSE_ENNEMIS_X

    RET

    VITESSE_NEG_ENNEMIS3_Y :

        NEG     VITESSE_ENNEMIS3_Y             ; VITESSE_ENNEMIS_Y devient - VITESSE_ENNEMIS_Y

    RET

MOUVEMENT_ENNEMIS3 ENDP

CREER_ENNEMIS3 PROC

    MOV     CX, ENNEMIS3_X
    MOV     DX, ENNEMIS3_Y

    CREER_ENNEMIS3_HORIZONTAL :

        MOV     AX,0C04H
        MOV     BH,0
        INT     10H

        INC     CX
        MOV     AX, CX
        SUB     AX, ENNEMIS3_X
        CMP     AX, ENNEMIS3_TAILLE
        JNG     CREER_ENNEMIS3_HORIZONTAL

        MOV     CX, ENNEMIS3_X

        INC     DX

        MOV     AX,DX
        SUB     AX, ENNEMIS3_Y
        CMP     AX, ENNEMIS3_TAILLE
        JNG     CREER_ENNEMIS3_HORIZONTAL

    RET

CREER_ENNEMIS3 ENDP

CREER_JOUEUR_GRIPPE PROC

    MOV     CX, JOUEUR_X
    MOV     DX, JOUEUR_Y

    CREER_JOUEUR_GRIPPE_HORIZONTAL :

        MOV     AX, 0C02H
        MOV     BH, 0
        INT     10H

        INC     CX
        MOV     AX, CX
        SUB     AX, JOUEUR_X
        CMP     AX, JOUEUR_TAILLE
        JNG     CREER_JOUEUR_GRIPPE_HORIZONTAL

        MOV     CX, JOUEUR_X

        INC     DX

        MOV     AX, DX
        SUB     AX, JOUEUR_Y
        CMP     AX, JOUEUR_TAILLE
        JNG     CREER_JOUEUR_GRIPPE_HORIZONTAL

        RET

CREER_JOUEUR_GRIPPE    ENDP

VERIF_J PROC

    MOV     I, 00H          ; Initialisation de I
    MOV     CX, JOUEUR_X
    MOV     DX, JOUEUR_Y
    MOV     BX, JOUEUR_TAILLE
    INC     BX                  ; BX = JOUEUR_TAILLE + 1 pour tester les contours du joueur

    DEC     DX                  ; Décrémentation de l'axe Y pour verifier la ranger du dessus

    VERIF_HAUT :

        MOV     AH, 0DH         ; Interruption permettant d'obtenir la couleur d'un pixel à l'aide des
        INT     10H             ; coordonnées fournis par CX et DX
        CMP     AL, 04H         ; Vérifie si le pixel n'est pas de couleur rouge
        JE      ECHEC           ; Si oui alors condition d'échec à vrai
        INC     CX              ; Incrémenter l'axe des x pour le prochain pixel
        INC     I               ; Incrémentation de la variable de la boucle
        CMP     BX, I           ; Nombres de fois que la boucle est executer
        JNE     VERIF_HAUT      ; Tant que i < TAILLE_JOUEUR + 1    boucler


    MOV     I, 00H          ; Réinitialisation de tout I, CX, DX à chaque VERIF_XXXX
    MOV     CX, JOUEUR_X
    MOV     DX, JOUEUR_Y

    ADD     CX, BX          ; X + TAILLE_JOUEUR + 1 pour vérifier la ranger de droite

    VERIF_DROITE :

        MOV     AH, 0DH         ; Interruption permettant d'obtenir la couleur d'un pixel à l'aide des
        INT     10H             ; des coordonnées fournis par CX et DX
        CMP     AL, 04H         ; Vérifie si le pixel n'est pas de couleur rouge
        JE      ECHEC           ; Si oui alors condition d'échec à vrai
        INC     DX              ; Incrémenter l'axe des y pour le prochain pixel
        INC     I               ; Incrémentation de la variable de la boucle
        CMP     BX, I           ; Nombres de fois que la boucle est executer
        JNE     VERIF_DROITE    ; Tant que i < TAILLE_JOUEUR + 1    boucler

    MOV     I, 00H          ; Réinitialisation de tout I, CX, DX à chaque VERIF_XXXX
    MOV     CX, JOUEUR_X
    MOV     DX, JOUEUR_Y

    ADD     CX, JOUEUR_TAILLE   ; x + TAILLE_JOUEUR
    ADD     DX, BX              ; y + TAILLE_JOUEUR + 1 (coordonnées pour être en bas à droite
                                ; est faire la ranger du bas de droite à gauche)

    VERIF_BAS :

        MOV     AH, 0DH         ; Interruption permettant d'obtenir la couleur d'un pixel à l'aide des
        INT     10H             ; des coordonnées fournis par CX et DX
        CMP     AL, 04H         ; Vérifie si le pixel n'est pas de couleur rouge
        JE      ECHEC           ; Si oui alors condition d'échec à vrai
        DEC     CX              ; Incrémenter l'axe des x pour le prochain pixel
        INC     I               ; Incrémentation de la variable de la boucle
        CMP     BX, I           ; Nombres de fois que la boucle est executer
        JNE     VERIF_BAS       ; Tant que i < TAILLE_JOUEUR + 1    boucler


    MOV     I, 00H          ; Réinitialisation de tout I, CX, DX à chaque VERIF_XXXX
    MOV     CX, JOUEUR_X
    MOV     DX, JOUEUR_Y

    DEC     CX                  ; Décrémentation de x pour la ranger de gauche en partant du bas
    ADD     DX, JOUEUR_TAILLE   ; y + JOUEUR_TAILLE

    VERIF_GAUCHE :

        MOV     AH, 0DH         ; Interruption permettant d'obtenir la couleur d'un pixel à l'aide des
        INT     10H             ; des coordonnées fournis par CX et DX
        CMP     AL, 04H         ; Vérifie si le pixel n'est pas de couleur rouge
        JE      ECHEC           ; Si oui alors condition d'échec à vrai
        DEC     DX              ; Incrémenter l'axe des y pour le prochain pixel
        INC     I               ; Incrémentation de la variable de la boucle
        CMP     BX, I           ; Nombres de fois que la boucle est executer
        JNE     VERIF_GAUCHE    ; Tant que i < TAILLE_JOUEUR + 1    boucler

    RET

    ECHEC:

        INC     PERDU           ; Incrémente la variable Perdu qui activera dans la boucle
                                ; la fonction defaite

    RET

VERIF_J ENDP

EFF_ECR PROC

    MOV     AH, 02H
	MOV 	BH, 00H
	MOV 	DH, TEMPS_ALT2
	MOV 	DL, 00H
	INT 	10H
	MOV     AH, 09H
	MOV     BH, 00H
	MOV 	AL, " "
	MOV 	BL, 00H
	MOV     CX, 40H
	INT 	10H
	INC 	TEMPS_ALT2
	CMP 	TEMPS_ALT2, 25
	JNE 	EFF_ECR
	MOV 	TEMPS_ALT2, 0
	RET

EFF_ECR ENDP

AFFICHE_SCORE_FINI PROC

    MOV     AL, 01H                         ; Mode d'écriture chaine de str
	MOV     BH, 00H                         ; Page 0
	MOV     BL, 0FH                         ; Couleur
	MOV     CX, SCORE_FIN2 - OFFSET SCORE2  ; Calcul la taille du message
	MOV     DL, 0AH                         ; Axe x du msg
	MOV     DH, 01H                         ; Axe y du msg
	PUSH    CS                              ; Quitte le segment code
	POP     ES                              ; Pour aller à L'extra segment
	MOV     BP, OFFSET SCORE2                ; Récuppère l'@ de score
	MOV     AH, 13H                         ; Fonction qui affiche le msg
	INT     10H
    JMP     SCORE_FIN2

    SCORE2 DB " Score FINAL :"
    SCORE_FIN2 :

        CALL CALCUL_SCORE       ; Appel de la procédure qui calcul le score

        MOV     BH, 00H       				; Page 0 défaut pour tout les affichages
        MOV     CX, 01H       				; Nombre de fois à afficher le caractère
                                            ; (Le même pour tous)

        MOV     AH, 02H       				; Placement du "curseur", ou le texte sera mis
        MOV     DL, 1BH       				; Colonnes
        MOV     DH, 01H       			    ; Lignes
        INT     10H

        MOV     AH, 09H       				; Fonction qui écrit 1 seul caractère
        MOV     BL, 0FH     				; Couleur
        MOV     AL, SCORE_UNITE_FINI  		; Caractère à imprimer
        INT     10H

        MOV     AH, 02H       				; Placement du "curseur", ou le texte sera mis
        MOV     DL, 1AH       				; Colonnes
        MOV     DH, 01H       			    ; Lignes
        INT     10H

        MOV     AH, 09H       				; Fonction qui écrit 1 seul caractère
        MOV     BL, 0FH     				; Couleur
        MOV     AL, SCORE_DIZAINE_FINI      ; Caractère à imprimer
        INT     10H

        MOV     AH, 02H       				; Placement du "curseur", ou le texte sera mis
        MOV     DL, 19H       				; Colonnes
        MOV     DH, 01H       			    ; Lignes
        INT     10H

        MOV     AH, 09H       				; Fonction qui écrit 1 seul caractère
        MOV     BL, 0FH     				; Couleur
        MOV     AL, SCORE_CENTAINE_FINI  	; Caractère à imprimer
        INT     10H

;creer
  mov  ah, 3ch
  mov  cx, 0
  mov  dx, offset nomfichier
  int  21h

  mov  handle, ax

;ecrire
  mov  ah, 40h
  mov  bx, handle
  mov  cx, 1  ;taille
  mov  dx, offset SCORE_CENTAINE_FINI
  int  21h

  mov  ah, 40h
  mov  bx, handle
  mov  cx, 1  ;taille
  mov  dx, offset SCORE_DIZAINE_FINI
  int  21h

  mov  ah, 40h
  mov  bx, handle
  mov  cx, 1  ;taille
  mov  dx, offset SCORE_UNITE_FINI
  int  21h

;fermer
  mov  ah, 3eh
  mov  bx, handle
  int  21h

        RET

AFFICHE_SCORE_FINI ENDP

DEFAITE PROC

    CALL     EFF_ECR
    CALL     BIP

    SCORE_FINAL:
        MOV     AL, SCORE_UNITE
        MOV     SCORE_UNITE_FINI, AL
        MOV     AL, SCORE_DIZAINE
        MOV     SCORE_DIZAINE_FINI, AL
        MOV     AL, SCORE_CENTAINE
        MOV     SCORE_CENTAINE_FINI, AL
        CALL    AFFICHE_SCORE_FINI

        TEST123455 :

            JMP TEST123455

RET

DEFAITE ENDP


        ;#######################################################################;
        ;#                       FONCTIONS UNIQUE A TRON                       #;
        ;#######################################################################;


CREER_JOUEUR1_TRON PROC

    MOV     CX, JOUEUR1_X_TRON
    MOV     DX, JOUEUR1_Y_TRON

    CREER_JOUEUR1_TRON_HORIZONTAL :

        MOV     AX, 0C09H
        MOV     BH, 0
        INT     10H

        INC     CX
        MOV     AX, CX
        SUB     AX, JOUEUR1_X_TRON
        CMP     AX, JOUEUR_TAILLE_TRON
        JNG     CREER_JOUEUR1_TRON_HORIZONTAL

        MOV     CX, JOUEUR1_X_TRON

        INC     DX

        MOV     AX, DX
        SUB     AX, JOUEUR1_Y_TRON
        CMP     AX, JOUEUR_TAILLE_TRON
        JNG     CREER_JOUEUR1_TRON_HORIZONTAL

RET

CREER_JOUEUR1_TRON    ENDP

CREER_JOUEUR2_TRON PROC

    MOV     CX, JOUEUR2_X_TRON
    MOV     DX, JOUEUR2_Y_TRON

    CREER_JOUEUR2_TRON_HORIZONTAL :

        MOV     AX, 0C0CH
        MOV     BH, 0
        INT     10H

        INC     CX
        MOV     AX, CX
        SUB     AX, JOUEUR2_X_TRON
        CMP     AX, JOUEUR_TAILLE_TRON
        JNG     CREER_JOUEUR2_TRON_HORIZONTAL

        MOV     CX, JOUEUR2_X_TRON

        INC     DX

        MOV     AX, DX
        SUB     AX, JOUEUR2_Y_TRON
        CMP     AX, JOUEUR_TAILLE_TRON
        JNG     CREER_JOUEUR2_TRON_HORIZONTAL

RET

CREER_JOUEUR2_TRON    ENDP

CLAVIER_TRON PROC

    MOV     AH, 01H             ; Recevoir l'état du buffer du clavier
    INT     16H                 ; Interruption d'obtention de touche du clavier
    JNZ     TOUCHE_DETECTER_TRON
    XOR     AX, AX              ; Vide le registre AX

    RET                     ; Return rien si aucune touche n'est presser

    TOUCHE_DETECTER_TRON:

    MOV     AH, 00H
    INT     16H                 ; Interruption d'obtention de touche du clavier

    CMP     AL, 1BH             ; Si touche "échap", alors sauter Le déplacement du joueur
    JE      ECHAP_TRON

    CMP     AL, 7AH             ; 7AH corresponds à "z" sur le clavier en Hex
    JE      JOUEUR1_TRON_HAUT          ; Aller à JOUEUR_HAUT

    CMP     AL, 73H             ; 73H corresponds à "s" sur le clavier en Hex
    JE      JOUEUR1_TRON_BAS           ; Aller à JOUEUR_BAS

    CMP     AL, 71H             ; 71H corresponds à "q" sur le clavier en Hex
    JE      JOUEUR1_TRON_GAUCHE        ; Aller à JOUEUR_GAUCHE

    CMP     AL, 64H             ; 64H corresponds à "d" sur le clavier en Hex
    JE      JOUEUR1_TRON_DROITE        ; Aller à JOUEUR_DROITE

    ; TOUCHES POUR JOUEUR 2

    CMP     AL, 69H             ; 69H corresponds à "i" sur le clavier en Hex
    JE      JOUEUR2_TRON_HAUT          ; Aller à JOUEUR_HAUT

    CMP     AL, 6BH             ; 6AH corresponds à "k" sur le clavier en Hex
    JE      JOUEUR2_TRON_BAS           ; Aller à JOUEUR_BAS

    CMP     AL, 6AH             ; 6BH corresponds à "j" sur le clavier en Hex
    JE      JOUEUR2_TRON_GAUCHE        ; Aller à JOUEUR_GAUCHE

    CMP     AL, 6CH             ; 6CH corresponds à "l" sur le clavier en Hex
    JE      JOUEUR2_TRON_DROITE        ; Aller à JOUEUR_DROITE

    RET

    ; Pour chaque déplacement du joueur ci-dessous, on récupère la position du joueur
    ; en x ou y et on modifie celle-ci par un déplacement de VITESSE_JOUEUR pixels

    JOUEUR1_TRON_HAUT :

        MOV     BX, JOUEUR1_Y_TRON
        SUB     BX, VITESSE_JOUEUR1_TRON
        MOV     JOUEUR1_Y_TRON, BX            ; Modification de y une fois la soustraction du pas de VITTESSE_JOUEUR faite

    RET

    JOUEUR1_TRON_BAS :

        MOV     BX, JOUEUR1_Y_TRON
        ADD     BX, VITESSE_JOUEUR1_TRON
        MOV     JOUEUR1_Y_TRON, BX

    RET

    JOUEUR1_TRON_GAUCHE :

        MOV     BX, JOUEUR1_X_TRON
        SUB     BX, VITESSE_JOUEUR1_TRON
        MOV     JOUEUR1_X_TRON, BX

    RET

    JOUEUR1_TRON_DROITE :

        MOV     BX, JOUEUR1_X_TRON
        ADD     BX, VITESSE_JOUEUR1_TRON
        MOV     JOUEUR1_X_TRON, BX

    RET

    ; TOUCHES POUR JOUEUR 2 ;

    JOUEUR2_TRON_HAUT :

    MOV     BX, JOUEUR2_Y_TRON
    SUB     BX, VITESSE_JOUEUR2_TRON
    MOV     JOUEUR2_Y_TRON, BX            ; Modification de y une fois la soustraction du pas de VITTESSE_JOUEUR faite

    RET

    JOUEUR2_TRON_BAS :

        MOV     BX, JOUEUR2_Y_TRON
        ADD     BX, VITESSE_JOUEUR2_TRON
        MOV     JOUEUR2_Y_TRON, BX

    RET

    JOUEUR2_TRON_GAUCHE :

        MOV     BX, JOUEUR2_X_TRON
        SUB     BX, VITESSE_JOUEUR2_TRON
        MOV     JOUEUR2_X_TRON, BX

    RET

    JOUEUR2_TRON_DROITE :

        MOV     BX, JOUEUR2_X_TRON
        ADD     BX, VITESSE_JOUEUR2_TRON
        MOV     JOUEUR2_X_TRON, BX

    RET

    ECHAP_TRON :

        MOV     AH, 00H
        INT     21H
                      ; Interruption mettant fin au programme
    RET

CLAVIER_TRON ENDP

VERIF_TRON PROC

    MOV TOUCHE_TRON, AL ; Récupère la touche précèdement toucher qui était dans AX
                        ; Pour ensuite vérifier dans sa direction

    CMP     TOUCHE_TRON, 7AH
    JE      VERIF1_HAUT

    CMP     TOUCHE_TRON, 64H
    JE      VERIF1_DROITE

    CMP     TOUCHE_TRON, 73H
    JE      VERIF1_BAS

    CMP     TOUCHE_TRON, 71H
    JE      VERIF1_GAUCHE

    CMP     TOUCHE_TRON, 69H
    JE      VERIF2_HAUT

    CMP     TOUCHE_TRON, 6CH
    JE      VERIF2_DROITE

    CMP     TOUCHE_TRON, 6BH
    JE      VERIF2_BAS

    CMP     TOUCHE_TRON, 6AH
    JE      VERIF2_GAUCHE

    JMP     AUTRE_TOUCHE_TRON



    VERIF1_HAUT :

        MOV     I, 00H
        MOV     CX, JOUEUR1_X_TRON
        MOV     DX, JOUEUR1_Y_TRON
        MOV     BX, JOUEUR_TAILLE_TRON

        DEC     DX

        VERIF1_HAUT_B :

            MOV     AH, 0DH
            INT     10H
            CMP     AL, 00H
            JNE     ECHEC1          ;Indique que le joueur 1 à perdu
            INC     CX
            INC     I
            CMP     BX, I
            JNE     VERIF1_HAUT_B
    RET

    VERIF1_DROITE :

        MOV     I, 00H
        MOV     CX, JOUEUR1_X_TRON
        MOV     DX, JOUEUR1_Y_TRON
        MOV     BX, JOUEUR_TAILLE_TRON

        ADD     CX, BX

        VERIF1_DROITE_B :

            MOV     AH, 0DH
            INT     10H
            CMP     AL, 00H
            JNE     ECHEC1
            INC     DX
            INC     I
            CMP     BX, I
            JNE     VERIF1_DROITE_B
    RET

    VERIF1_BAS :

        MOV     I, 00H
        MOV     CX, JOUEUR1_X_TRON
        MOV     DX, JOUEUR1_Y_TRON
        MOV     BX, JOUEUR_TAILLE_TRON

        ADD     CX, BX
        ADD     DX, BX

        VERIF1_BAS_B :

            MOV     AH, 0DH
            INT     10H
            CMP     AL, 00H
            JNE     ECHEC1
            DEC     CX
            INC     I
            CMP     BX, I
            JNE     VERIF1_BAS_B
    RET

     VERIF1_GAUCHE :

        MOV     I, 00H
        MOV     CX, JOUEUR1_X_TRON
        MOV     DX, JOUEUR1_Y_TRON
        MOV     BX, JOUEUR_TAILLE_TRON

        DEC     CX
        ADD     DX, BX

        VERIF1_GAUCHE_B :

            MOV     AH, 0DH
            INT     10H
            CMP     AL, 00H
            JNE     ECHEC1
            DEC     DX
            INC     I
            CMP     BX, I
            JNE     VERIF1_GAUCHE_B
    RET



    VERIF2_HAUT :

        MOV     I, 00H
        MOV     CX, JOUEUR2_X_TRON
        MOV     DX, JOUEUR2_Y_TRON
        MOV     BX, JOUEUR_TAILLE_TRON

        DEC DX
        VERIF2_HAUT_B :

            MOV     AH, 0DH
            INT     10H
            CMP     AL, 00H
            JNE     ECHEC2
            INC     CX
            INC     I
            CMP     BX, I
            JNE     VERIF2_HAUT_B
    RET

    VERIF2_DROITE :

        MOV     I, 00H
        MOV     CX, JOUEUR2_X_TRON
        MOV     DX, JOUEUR2_Y_TRON
        MOV     BX, JOUEUR_TAILLE_TRON

        ADD     CX, BX

        VERIF2_DROITE_B :

            MOV     AH, 0DH
            INT     10H
            CMP     AL, 00H
            JNE     ECHEC2
            INC     DX
            INC     I
            CMP     BX, I
            JNE     VERIF2_DROITE_B
    RET

    VERIF2_BAS :

        MOV     I, 00H
        MOV     CX, JOUEUR2_X_TRON
        MOV     DX, JOUEUR2_Y_TRON
        MOV     BX, JOUEUR_TAILLE_TRON

        ADD     CX, BX
        ADD     DX, BX

        VERIF2_BAS_B :

            MOV     AH, 0DH
            INT     10H
            CMP     AL, 00H
            JNE     ECHEC2
            DEC     CX
            INC     I
            CMP     BX, I
            JNE     VERIF2_BAS_B
    RET

     VERIF2_GAUCHE :

        MOV     I, 00H
        MOV     CX, JOUEUR2_X_TRON
        MOV     DX, JOUEUR2_Y_TRON
        MOV     BX, JOUEUR_TAILLE_TRON

        DEC     CX
        ADD     DX, BX

        VERIF2_GAUCHE_B :

            MOV     AH, 0DH
            INT     10H
            CMP     AL, 00H
            JNE     ECHEC2
            DEC     DX
            INC     I
            CMP     BX, I
            JNE     VERIF2_GAUCHE_B
    RET

    ECHEC1 :

        MOV     JOUEUR_PERDU_TRON, 00H
        MOV     PERDU, 01H

    RET

    ECHEC2 :

        MOV     JOUEUR_PERDU_TRON, 01H
        MOV     PERDU, 01H

    RET

    AUTRE_TOUCHE_TRON :

    RET

VERIF_TRON ENDP

DEFAITE_TRON PROC
;Q POUR QUITTER

    CALL EFF_ECR
    CMP JOUEUR_PERDU_TRON, 00H
    JNE VICTOIRE_J1
    MOV		BP, offset PERDU_TRON_J1              ; Ecriture du message
	MOV 	AH, 13H                         ; Ecrire dans une chaîne de char
	MOV		BH, 00H                         ; Numéro de page
	MOV		BL, 04H                         ; Attributs ( couleur ...)
	MOV		AL, 00H                         ; Mode écriture
	MOV 	CX, 11                          ; Nombre de char dans le String
	MOV 	DL, 04                          ; Colonne
	MOV		DH, 07                          ; Ligne
	INT		10H                             ; Interruption mode vidéo

    MOV		BP, offset PERDU2_TRON_J1               ; Ecriture du message
	MOV 	AH, 13H                         ; Ecrire dans une chaîne de char
	MOV		BH, 00H                         ; Numéro de page
	MOV		BL, 04H                         ; Attributs ( couleur ...)
	MOV		AL, 00H                         ; Mode écriture
	MOV 	CX, 28                          ; Nombre de char dans le String
	MOV 	DL, 08                          ; Colonne
	MOV		DH, 10                          ; Ligne
	INT		10H                             ; Interruption mode vidéo

    JMP MSG_FIN_TRON

    VICTOIRE_J1 :


    MOV		BP, offset PERDU_TRON_J2        ; Ecriture du message
	MOV 	AH, 13H                         ; Ecrire dans une chaîne de char
	MOV		BH, 00H                         ; Numéro de page
	MOV		BL, 04H                         ; Attributs ( couleur ...)
	MOV		AL, 00H                         ; Mode écriture
	MOV 	CX, 10                          ; Nombre de char dans le String
	MOV 	DL, 04                          ; Colonne
	MOV		DH, 07                          ; Ligne
	INT		10H                             ; Interruption mode vidéo

    MOV		BP, offset PERDU2_TRON_J2       ; Ecriture du message
	MOV 	AH, 13H                         ; Ecrire dans une chaîne de char
	MOV		BH, 00H                         ; Numéro de page
	MOV		BL, 04H                         ; Attributs ( couleur ...)
	MOV		AL, 00H                         ; Mode écriture
	MOV 	CX, 25                          ; Nombre de char dans le String
	MOV 	DL, 08                          ; Colonne
	MOV		DH, 10                          ; Ligne
	INT		10H                             ; Interruption mode vidéo

    MSG_FIN_TRON :

    MOV		BP,offset MSG_FIN1          ; Ecriture du message
    MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
    MOV		BH, 00H                     ; Numéro de page
    MOV		BL, 0FH                     ; Attributs ( couleur ...)
    MOV		AL, 00H                     ; Mode écriture
    MOV 	CX, 24                      ; Nombre de char dans le String
    MOV 	DL, 10                      ; Colonne
    MOV		DH, 16                      ; Ligne
    INT		10H                         ; Interruption mode vidéo

    MOV		BP,offset MSG_FIN2          ; Ecriture du message
    MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
    MOV		BH, 00H                     ; Numéro de page
    MOV		BL, 0FH                     ; Attributs ( couleur ...)
    MOV		AL, 00H                     ; Mode écriture
    MOV 	CX, 17                      ; Nombre de char dans le String
    MOV 	DL, 10                      ; Colonne
    MOV		DH, 18                      ; Ligne
    INT		10H                         ; Interruption mode vidéo

    MOV		BP,offset MSG_FIN3          ; Ecriture du message
    MOV 	AH, 13H                     ; Ecrire dans une chaîne de char
    MOV		BH, 0FH                     ; Numéro de page
    MOV		BL, 0FH                     ; Attributs ( couleur ...)
    MOV		AL, 00H                     ; Mode écriture
    MOV 	CX, 21                      ; Nombre de char dans le String
    MOV 	DL, 10                      ; Colonne
    MOV		DH, 20                      ; Ligne
    INT		10H                         ; Interruption mode vidéo


    RET

DEFAITE_TRON ENDP

REINIT_VARI_TRON PROC

    MOV PERDU, 00H                      ; Réintialisation de toutes les variables pour y rejouer
    MOV JOUEUR_PERDU_TRON, 03H
    MOV JOUEUR1_X_TRON, 01CH
    MOV JOUEUR1_Y_TRON, 01AH
    MOV JOUEUR2_X_TRON, 115H
    MOV JOUEUR2_Y_TRON, 09FH

RET

REINIT_VARI_TRON ENDP

CSEG        ENDS

END         MAIN