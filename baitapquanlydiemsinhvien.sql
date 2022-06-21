create database quanlydiem;

create table sinhvien(
MaSV int primary key,
TenSV varchar(255),
NgaySinh date,
HocBong varchar(255),
GioTinh varchar(255),
MaLop int,
foreign key (MaLop) references lop(MaLop)
);

create table lop(
MaLop int primary key,
TenLop varchar(255),
MaKhoa int,
foreign key (MaKhoa) references khoa(MaKhoa)
);

create table khoa(
Makhoa int primary key,
TenKhoa varchar(255)
);

create table monhoc(
MaMonHoc int primary key,
TenMonHoc varchar(255),
SoTiet int
);

create table ketqua(
MaSV int,
MaMonHoc int,
Diem float,
foreign key (MaSV) references sinhvien(MaSV),
foreign key (MaMonHoc) references monhoc(MaMonHoc)
);

INSERT INTO sinhvien value (1, 'Han Van Toi', '1993-04-01', 1, 'Nam', 1);
INSERT INTO sinhvien value (2, 'Pham Thi Lan Anh', '1998-10-20', 1, 'Nu', 2);
INSERT INTO sinhvien value (3, 'Tran Hoang Minh', '2000-07-06', 0, 'Nam', 1);
INSERT INTO sinhvien value (4, 'Khong Minh', '2003-10-22', 0, 'Nam', 3);

INSERT INTO ketqua value (1,  1, 9), (1,  2, 8.5), (1,  3, 8) ;
INSERT INTO ketqua value (2,  1, 8), (2,  2, 8), (2,  3, 8);
INSERT INTO ketqua value (3,  1, 7), (3,  2, 10), (3,  3, 7);
INSERT INTO ketqua value (4,  1, 10),(4,  2, 8.5), (4,  3, 9.5);


#Câu 5: Lập danh sách sinh viên có họ ‘Trần’
select * 
from sinhvien
where TenSV like 'Tran%';

#Câu 6: Lập danh sách sinh viên nữ có học bổng
select *
from sinhvien
where GioTinh = 'Nu' and HocBong = 1;

#Câu 7: Lập danh sách sinh viên nữ hoặc danh sách sinh viên có học bổng
select *
from sinhvien
where GioTinh = 'Nu' or HocBong = 1;

#Câu 8: Lập danh sách sinh viên có năm sinh từ 1978 đến 1985. Danh sách cần các thuộc tính của quan hệ SinhVien
select sinhvien.*, lop.TenLop, khoa.tenkhoa
from quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.Makhoa = khoa.makhoa
where year(ngaysinh) BETWEEN 1995 AND 1999  ;

#Câu 9: Liệt kê danh sách sinh viên được sắp xếp tăng dần theo MaSV
select *
from sinhvien
order by MaSV DESC;

#Câu 10: Liệt kê danh sách sinh viên được sắp xếp giảm dần theo HocBong
select *
from sinhvien
order by MaSV ASC;

#Ví du 12: Lập danh sách sinh viên có học bổng của khoa CNTT.
select sinhvien.*, lop.TenLop, khoa.tenkhoa
from quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.Makhoa = khoa.makhoa
where HocBong = 1 and tenkhoa = "CNTT";

#Ví du 13: Lập danh sách sinh viên có học bổng của khoa CNTT. 
select sinhvien.*, lop.TenLop, khoa.tenkhoa
from quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.Makhoa = khoa.makhoa
where HocBong = 1 and tenkhoa = "CNTT";

#Câu 14: Cho biết số sinh viên của mỗi lớp
SELECT TenLop , COUNT(MaSV) as 'Tong Sv'
FROM quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop
group by TenLop;

#Câu 15: Cho biết số lượng sinh viên của mỗi khoa.
SELECT tenKhoa, COUNT(MaSV) as 'Tong Sv moi khoa'
from quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.Makhoa = khoa.makhoa
group by tenkhoa;

#Câu 16: Cho biết số lượng sinh viên nữ của mỗi khoa.
SELECT tenKhoa, COUNT(MaSV) as 'Tong Sv nu cua khoa'
from quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.Makhoa = khoa.makhoa
where GioTinh = 'Nu'
group by tenkhoa;

#Câu 17: Cho biết tổng tiền học bổng của mỗi lớp
SELECT TenLop , COUNT(MaSV) as 'Tong hoc bong'
FROM quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop
where HocBong = 1
group by TenLop;

#Câu 18: Cho biết tổng số tiền học bổng của mỗi khoa
SELECT tenKhoa , COUNT(MaSV) as 'Tong hoc bong'
from quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.Makhoa = khoa.makhoa
where HocBong = 1
group by tenkhoa;

#Câu 19: Lập danh sánh những khoa có nhiều hơn 100 sinh viên. Danh sách cần: MaKhoa, TenKhoa, Soluong
SELECT  khoa.makhoa, tenKhoa, COUNT(MaSV) as 'SoLuong'
from quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.Makhoa = khoa.makhoa
group by tenkhoa
having SoLuong > 1;

#Câu 20: Lập danh sánh những khoa có nhiều hơn 50 sinh viên nữ. Danh sách cần: MaKhoa, TenKhoa, Soluong
SELECT  khoa.makhoa, tenKhoa, COUNT(MaSV) as 'SoLuong'
from quanlydiem.sinhvien join lop on sinhvien.MaLop = lop.MaLop join khoa on lop.Makhoa = khoa.makhoa
where GioTinh = 'Nam'
group by tenkhoa
having SoLuong > 1 ;

#Câu22: Lập danh sách sinh viên có học bổng cao nhất

#Câu 23: Lập danh sách sinh viên có điểm thi môn toán cao nhất


