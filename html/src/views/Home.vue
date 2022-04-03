<script lang="ts" setup>
import { computed } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import Deposit from "../assets/img/Deposit.svg";
import Withdraw from "../assets/img/Withdraw.svg";

const router = useRouter();
const store = useStore();

const playerData = computed(() => store.state.player);
</script>

<template lang="pug">
main.atm__content
  h1.atm__title Bienvenue dans votre espace bancaire
  p.atm__message Montant disponible :

  h2.atm__amount {{ playerData.accounts.bank.toLocaleString('fr-FR') }} $

  .atm__actions
    button.atm__button(@click="router.push({ name: 'action', params: {state: 'deposit'} })")
      .atm__button-withicon
        Deposit
        | Déposer
    button.atm__button(@click="router.push({ name: 'action', params: {state: 'withdraw'} })")
      .atm__button-withicon
        Withdraw
        | Retirer
</template>

<style lang="scss"></style>
