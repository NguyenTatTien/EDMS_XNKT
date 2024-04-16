<template>
    <a-list
      class="demo-loadmore-list"
      :loading="initLoading"
      item-layout="horizontal"
      :data-source="list"
    >
      <template #loadMore>
        <div
          v-if="!initLoading && !loading"
          :style="{ textAlign: 'center', marginTop: '12px', height: '32px', lineHeight: '32px' }"
        >
          <a-button @click="onLoadMore">loading more</a-button>
        </div>
      </template>
      <template #renderItem="{ item }">
        <a-list-item>
          <template #actions>

          </template>
          <a-skeleton avatar :title="false" :loading="!!item.loading" active>
            <a-list-item-meta
              description="Ant Design, a design language for"
            >
              <template #title>
                <a href="https://www.antdv.com/">{{ item.name.last }}</a>
              </template>
              <template #avatar>
                <a-avatar :src="item.picture.large" />
              </template>
            </a-list-item-meta>
            <div>
                <!-- content -->
            </div>
          </a-skeleton>
        </a-list-item>
      </template>
    </a-list>
  </template>
  <script lang="ts" setup>
  import { onMounted, ref, nextTick } from 'vue';
  const count = 5;
  const fakeDataUrl = `https://randomuser.me/api/?results=${count}&inc=name,gender,email,nat,picture&noinfo`;
  
  const initLoading = ref(true);
  const loading = ref(false);
  const data = ref([]);
  const list = ref([]);
  onMounted(() => {
    fetch(fakeDataUrl)
      .then(res => res.json())
      .then(res => {
        initLoading.value = false;
        data.value = res.results;
        list.value = res.results;
      });
  });
  
  const onLoadMore = () => {
    loading.value = true;
    list.value = data.value.concat(
      [...new Array(count)].map(() => ({ loading: true, name: {}, picture: {} })),
    );
    fetch(fakeDataUrl)
      .then(res => res.json())
      .then(res => {
        const newData = data.value.concat(res.results);
        loading.value = false;
        data.value = newData;
        list.value = newData;
        nextTick(() => {
          // Resetting window's offsetTop so as to display react-virtualized demo underfloor.
          // In real scene, you can using public method of react-virtualized:
          // https://stackoverflow.com/questions/46700726/how-to-use-public-method-updateposition-of-react-virtualized
          window.dispatchEvent(new Event('resize'));
        });
      });
  };
  </script>
  <style>
  .demo-loadmore-list {
    min-height: 350px;
  }
  :where(.css-dev-only-do-not-override-1hsjdkk).ant-list .ant-list-item .ant-list-item-meta .ant-list-item-meta-title {
    margin-bottom: 4px;
    color: rgba(0, 0, 0, 0.88);
    font-size: 14px;
    line-height: 1.5714285714285714;
    margin-top: 0 !important;
}
  </style>
  