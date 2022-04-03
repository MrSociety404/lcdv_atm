<script lang="ts" setup>
import { computed } from "@vue/reactivity";
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";

import Alert from "../assets/img/alert.svg";

const router = useRouter();
const store = useStore();

const inputAmount = ref();
const isAlert = ref(false);
const playerData = computed(() => store.state.player);

const handleWithdraw = () => {
  // Validate the input amount
  if (
    inputAmount.value < 0 ||
    inputAmount.value > playerData.value.accounts.bank
  ) {
    showAlert();
    return;
  }
  fetch("https://lcdv_atm/withdraw", {
    method: "POST",
    body: JSON.stringify({
      amount: inputAmount.value,
    }),
  });
  inputAmount.value = 0;
  router.push({ name: "home" });
};

const handleDeposit = () => {
  // Validate the input amount
  if (
    inputAmount.value < 0 ||
    inputAmount.value > playerData.value.accounts.cash
  ) {
    showAlert();
    return;
  }
  fetch("https://lcdv_atm/deposit", {
    method: "POST",
    body: JSON.stringify({
      amount: inputAmount.value,
    }),
  });
  inputAmount.value = 0;
  router.push({ name: "home" });
};

const showAlert = () => {
  isAlert.value = true;
  setTimeout(() => {
    isAlert.value = false;
  }, 2000);
};
</script>

<template lang="pug">
main.atm__content
  h1.atm__title(v-if='$route.params.state === "withdraw" ') Retrait d'argent
  h1.atm__title(v-else) Dépot d'argent

  .actions__amount
    input(type='number' placeholder="0" v-model='inputAmount')
  p.actions__message(v-if='$route.params.state === "withdraw" ') Disponible pour le retrait : {{ playerData.accounts.bank.toLocaleString('fr-FR') }} $

  .atm__actions
    button.atm__button.atm__button-light(@click="router.push({ name: 'home'})")
      | Annuler
    button.atm__button(v-if='$route.params.state === "withdraw" '  @click="handleWithdraw")
      | Continuer
    button.atm__button(v-else @click="handleDeposit")
      | Continuer
  transition(name='from-bottom')  
    .alert(v-if='isAlert')
      Alert
      h2 Montant invalide, veuillez recommencer l’action
</template>

<style lang="scss">
.actions {
  &__amount {
    color: var(--textColor);
    font-size: 3em;
    margin-block: 2.5rem;
  }
  &__message {
    color: var(--secondaryColor);
    margin-bottom: 3em;
  }
}
.alert {
  display: flex;
  align-items: center;
  justify-content: space-evenly;
  gap: 1rem;
  padding: 1rem 3rem;
  border-radius: 0.5rem;
  background-color: var(--dangerColor);
  color: var(--textColor);
  font-size: 1.2rem;
  position: absolute;
  bottom: -3rem;
}
.from-bottom-enter-active,
.from-bottom-leave-active {
  transition: all 0.4s ease-in-out;
}
.from-bottom,
.from-bottom-leave-to {
  opacity: 0;
  transform: translateY(3rem);
}
</style>
