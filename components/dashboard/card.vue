<template>
    <div class="flex-noshuink w-full h-full shadow-md p-3 rounded-lg">
        <div class="w-full flex flex-wrap">
            <span class="w-full text-lg border border-b border-gray-300 mb-3 text-gray-500">
                <slot>
                    
                </slot>
            </span>
            <span class="w-full">
                <slot name="content">
                    Content
                </slot>
            </span>
        </div>
    </div>
</template>