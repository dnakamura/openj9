add_executable(dfixtest
	main.cpp
)

target_link_libraries(dfixtest
	PRIVATE
	j9vm_interface
)