import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";
import Action from "../views/Action.vue";

const routes: any = [
  {
    path: "/",
    name: "home",
    component: Home,
  },
  {
    path: "/action/:state",
    name: "action",
    component: Action,
  },
  {
    path: "/:pathMatch(.*)*",
    redirect: "/",
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
