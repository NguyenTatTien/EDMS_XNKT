// composables/useSignalR.ts
import { ref, onMounted, onUnmounted } from 'vue';
import { useNuxtApp } from '#app';

// Hàm quản lý SignalR
export const useSignalR = () => {
  const { $signalr } = useNuxtApp(); // Truy cập SignalR từ plugin

  // Lắng nghe sự kiện nhận tin nhắn
  const listenToMessages = (callback: (data: {objectID: number, userID: number,members:any, message: any}) => void) => {
    if ($signalr) {
      // Lắng nghe sự kiện 'ReceiveMessage' và gọi callback để truyền dữ liệu ra ngoài
      $signalr.on('ReceiveMessage', (objectID: number, userID: number,members:any, message: any) => {
        callback({ objectID, userID,members, message });
      });
    } else {
      console.error('SignalR connection not available');
    }
  };
  // Dừng lắng nghe sự kiện khi component bị huỷ
  const stopListening = () => {
    if ($signalr) {console.log("stop");
      $signalr.off('ReceiveMessage'); // Tắt sự kiện khi không cần nữa
    }
  };
  // Gửi tin nhắn tới server
  const sendMessage = (objectID: number,userID: number,members:any, message: any) => {
    if ($signalr) {
        $signalr.invoke('SendMessage', objectID, userID,members, message)
        .catch(err => console.error(err));
    }
  };

  onMounted(() => {

  });

  onUnmounted(() => {
  });

  return {
    listenToMessages,
    sendMessage,
  };
};