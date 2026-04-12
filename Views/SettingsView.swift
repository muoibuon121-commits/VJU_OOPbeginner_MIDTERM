import SwiftUI

struct SettingsView: View {
    @State private var isAutoSyncEnabled = AppConstants.Sync.isAutoSyncEnabled
    @State private var syncInterval = AppConstants.Sync.interval
    @State private var defaultVATRate = AppConstants.Finance.defaultVATRate * 100
    @State private var defaultDiscountRate = AppConstants.Finance.defaultDiscountRate * 100
    @State private var showingResetAlert = false
    @State private var showingExportAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Cài đặt ứng dụng")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Sync Settings
                VStack(alignment: .leading, spacing: 12) {
                    Text("Cài đặt đồng bộ")
                        .font(.headline)
                    
                    VStack(spacing: 12) {
                        Toggle("Bật đồng bộ tự động", isOn: $isAutoSyncEnabled)
                        
                        if isAutoSyncEnabled {
                            Slider(value: $syncInterval, in: 60...600, step: 60)
                            
                            HStack {
                                Text("Khoảng thời gian:")
                                Spacer()
                                Text("\(Int(syncInterval)) giây")
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .padding()
                    .background(AppConstants.Colors.neutral)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Finance Settings
                VStack(alignment: .leading, spacing: 12) {
                    Text("Cài đặt tài chính")
                        .font(.headline)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("VAT mặc định:")
                            Spacer()
                            TextField("", value: $defaultVATRate, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 80)
                            Text("%")
                        }
                        
                        HStack {
                            Text("Chiết khấu mặc định:")
                            Spacer()
                            TextField("", value: $defaultDiscountRate, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 80)
                            Text("%")
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Đơn vị tiền tệ")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(AppConstants.Finance.currencyCode)
                                .fontWeight(.semibold)
                        }
                    }
                    .padding()
                    .background(AppConstants.Colors.neutral)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Data Management
                VStack(alignment: .leading, spacing: 12) {
                    Text("Quản lý dữ liệu")
                        .font(.headline)
                    
                    VStack(spacing: 8) {
                        Button(action: { showingExportAlert = true }) {
                            Label("Xuất dữ liệu", systemImage: "square.and.arrow.up")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .buttonStyle(.bordered)
                        
                        Button(action: { showingResetAlert = true }) {
                            Label("Xóa tất cả dữ liệu", systemImage: "trash")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                    .background(AppConstants.Colors.neutral)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // About
                VStack(alignment: .leading, spacing: 12) {
                    Text("Về ứng dụng")
                        .font(.headline)
                    
                    VStack(spacing: 8) {
                        DetailRow(label: "Tên ứng dụng", value: AppConstants.companyName)
                        DetailRow(label: "Phiên bản", value: AppConstants.appVersion)
                        DetailRow(label: "Build", value: AppConstants.appBuild)
                    }
                    .padding()
                    .background(AppConstants.Colors.neutral)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .alert("Xóa tất cả dữ liệu?", isPresented: $showingResetAlert) {
            Button("Hủy", role: .cancel) { }
            Button("Xóa", role: .destructive) {
                CoreDataManager.shared.resetAllData()
            }
        } message: {
            Text("Hành động này không thể hoàn tác. Tất cả dữ liệu sẽ bị xóa vĩnh viễn.")
        }
        .alert("Xuất dữ liệu", isPresented: $showingExportAlert) {
            Button("Hủy", role: .cancel) { }
            Button("Xuất") {
                exportData()
            }
        } message: {
            Text("Dữ liệu sẽ được xuất dưới dạng tệp JSON.")
        }
    }
    
    private func exportData() {
        print("Đang xuất dữ liệu...")
        // Implement export logic
    }
}

#Preview {
    SettingsView()
}
