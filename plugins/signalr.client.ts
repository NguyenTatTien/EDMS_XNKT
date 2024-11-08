import { HubConnection, HubConnectionBuilder } from '@microsoft/signalr';
import { useDomain } from '@/stores/domain';

let connection: HubConnection | null = null; // Biến tĩnh để lưu trữ kết nối

export default defineNuxtPlugin(() => {
  // Tạo kết nối SignalR chỉ nếu chưa có kết nối nào
  if (!connection) {
    const server = useDomain().url.server;
    connection = new HubConnectionBuilder()
      .withUrl(`${server}chathub`, {
        withCredentials: true
      })
      .withAutomaticReconnect()
      .build();

    // Bắt đầu kết nối
    connection.start()
      .then(() => console.log('SignalR connection established'))
      .catch(err => console.error('SignalR Connection Error:', err));
  }

  return {
    provide: {
      signalr: connection // Cung cấp kết nối SignalR để sử dụng trong toàn bộ ứng dụng
    }
  };
});