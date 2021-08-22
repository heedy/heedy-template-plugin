<template>
  <h-card-page title="Main page for myplugin!" :alert="alert">
    <h-loading v-if="output == null" />
    <v-flex v-else text-center>
      <h3>Server Response:</h3>
      <p>{{ JSON.stringify(output) }}</p>
    </v-flex>
  </h-card-page>
</template>
<script>
export default {
  data: () => ({
    output: null,
    alert: "",
  }),
  methods: {
    load_output: async function () {
      let res = await this.$frontend.rest("GET", "/api/myplugin");
      if (!res.response.ok) {
        this.alert = res.data.error_description;
        return;
      }
      this.output = res.data;
    },
  },
  created() {
    this.load_output();
  },
};
</script>
