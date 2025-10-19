<template>
  <q-page class="flex flex-center">
    <div>
      <h3>Production Page - v1.4</h3>
      <p>Last updated: {{ new Date().toLocaleDateString() }}</p>
      <img
        alt="Quasar logo"
        src="~assets/quasar-logo-vertical.svg"
        style="width: 200px; height: 200px"
      />
    </div>
  </q-page>
</template>

<script>
import { defineComponent } from "vue";

export default defineComponent({
  name: "IndexPage",
});
</script>
