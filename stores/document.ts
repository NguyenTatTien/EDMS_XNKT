import { defineStore } from 'pinia'

export const useDocument = defineStore('document', {
  state: () => {
    return {
        rawData: [
            {
              id: 1,
              name: 'root',
              slug: '#',
              type: 1,
              is_dir: true,
              data: [],
              parentId: null
            },
            {
                id: 1,
                name: 'word 1',
                slug: 'word-1',
                type: 1,
                mimeType: 'application/word',
                link: {
                    src: '',
                    review: '',
                    screenshot: ''
                },
                is_dir: false,
                folder: 1
            },
            {
                id: 2,
                name: 'excel 2',
                slug: '#',
                type: 1,
                mimeType: 'application/excel',
                link: {
                    src: '',
                    review: '',
                    screenshot: ''
                },
                is_dir: false,
                folder: 1
            },
            {
              id: 2,
              name: 'folder 1',
              slug: 'folder-1',
              type: 1,
              is_dir: true,
              data: [],
              parentId: 1
            },
            {
              id: 3,
              name: 'folder 2',
              slug: 'folder-2',
              type: 1,
              is_dir: true,
              data: [],
              parentId: 2
            }
        ],
        data: [] as TreeItem[]
    }
  },
  actions: {
    init() {
      this.data = this.buildTree(this.rawData as TreeItem[]);
      console.log(this.data)
    },
    getFolderBySlug(slugs: string[], data: any): any {
        try {
            console.log(slugs,data)
            if (slugs.length === 0) {
              return { slug: '', data: [] };
            }
          
            const currentSlug = slugs.shift();
            const foundFolder = data.find((item: { slug: string }) => item.slug === currentSlug);
    
            console.log(foundFolder)
          
            if (!foundFolder || !foundFolder.is_dir) {
              return null; // Folder not found or not a directory
            }
          
            if (slugs.length === 0) {
              return foundFolder; // Reached the end of the slugs, return the found folder
            }
          
            return this.getFolderBySlug(slugs, foundFolder.data); // Recursive call for the next slug
        }
        catch (error) {
            return null
        }
    },
    moveFileToFoldeer(file: any, folder: any) {
        console.log(file, folder)
        var _file = this.findByIdAndIsDir(this.data, file, false)
        var _folder = this.findByIdAndIsDir(this.data, folder, true)
        console.log(toRaw(_file),toRaw(_folder))
    },
    findByIdAndIsDir(data: any[], id: number, isDir: boolean): any | null {
        for (let item of data) {
          if (item.id == id && item.is_dir == isDir) {
            return item;
          }
          if (item.data && item.data.length > 0) {
            const result = this.findByIdAndIsDir(item.data, id, isDir);
            if (result) {
              return result;
            }
          }
        }
        return null;
    },
    buildTree(rawData: TreeItem[]) {
      var root = this.findByIdAndIsDir(rawData, 1, true)
      var childs = rawData.filter(p=>p.is_dir == true && p.parentId == null)
      console.log(root, childs);
    }
  },
  persist: {
    storage: persistedState.localStorage,
  },
})
interface TreeNode {
  id: number;
  name: string;
  type: number;
  mimeType: string | null;
  link: {
      src: string;
      review: string;
      screenshot: string;
  } | null;
  isDir: boolean;
  data: TreeNode[];
}

// Interface for raw data items
interface TreeItem {
  id: number;
  name: string;
  slug: string;
  type: number;
  mimeType: string | null;
  link: {
      src: string;
      review: string;
      screenshot: string;
  } | null;
  is_dir: boolean;
  folder?: number;
  data?: number[];
  parentId?: number;
}