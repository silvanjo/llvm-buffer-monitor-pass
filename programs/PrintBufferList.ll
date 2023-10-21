
@formatStr = private constant [4 x i8] c"%s\0A\00"
@formatSizeStr = private constant [11 x i8] c"Size: %ld\0A\00"

define void @printBufferList() {
entry:
  %current = load %BufferNode*, %BufferNode** @BufferListHead, align 8

  ; Check if list is empty
  %isEmpty = icmp eq %BufferNode* %current, null
  br i1 %isEmpty, label %exit, label %loop_body

loop_body:
  ; Print i8* content
  %dataPtr = getelementptr inbounds %BufferNode, %BufferNode* %current, i32 0, i32 0
  %data = load i8*, i8** %dataPtr, align 8
  ; Assuming the data is a null-terminated string; if not, this won't print correctly
  %format_ptr = getelementptr [4 x i8], [4 x i8]* @formatStr, i64 0, i64 0
  call i32 (i8*, ...) @printf(i8* %format_ptr, i8* %data)

  ; Print i64 content
  %dataSizePtr = getelementptr inbounds %BufferNode, %BufferNode* %current, i32 0, i32 1
  %dataSize = load i64, i64* %dataSizePtr, align 8
  %format_ptr_size = getelementptr [11 x i8], [11 x i8]* @formatSizeStr, i64 0, i64 0
  call i32 (i8*, ...) @printf(i8* %format_ptr_size, i64 %dataSize)


  ; Move to the next node
  %nextPtr = getelementptr inbounds %BufferNode, %BufferNode* %current, i32 0, i32 2
  %next = load %BufferNode*, %BufferNode** %nextPtr, align 8
  %isEnd = icmp eq %BufferNode* %next, null
  br i1 %isEnd, label %exit, label %loop_body

exit: 
  ret void
}