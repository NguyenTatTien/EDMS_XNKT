import { defineStore } from 'pinia'

export const useKhoiBanPhong = defineStore('khoibanphong', {
  state: () => {
    return {
        khoi: [
            { id: 0, name: 'Xí nghiệp khí', code: 'NY' },
            { id: 1, name: 'Xí nghiệp khoan', code: 'RM' },
            { id: 2, name: 'Xí nghiệp khai thác', code: 'RM' },
        ],
        ban: [
            { id: 0, name: 'Ban giảm đốc', code: 'NY' },
            { id: 1, name: 'Ban quản lý', code: 'RM' },
            { id: 2, name: 'Ban sản xuất', code: 'RM' },
        ],
        phong: [
            { id: 0, name: 'Phòng nhân sự', code: 'NY' },
            { id: 1, name: 'Phòng tài chính kế toán', code: 'RM' },
            { id: 2, name: 'Phòng Marketing', code: 'MKT' },
            { id: 3, name: 'Phòng CNTT', code: 'CNTT' },
            { id: 4, name: 'Phòng chăm sóc khách hàng', code: 'CSKH' },
        ],
    }
  },
  persist: {
    storage: persistedState.localStorage,
  },
})