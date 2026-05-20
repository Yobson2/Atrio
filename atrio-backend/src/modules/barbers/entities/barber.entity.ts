import { Entity, Column } from 'typeorm';
import { BaseEntity } from '@common/database/base.entity';

@Entity('barbers')
export class Barber extends BaseEntity {
  @Column()
  salonId: string;

  @Column({ nullable: true })
  userId: string;

  @Column()
  name: string;

  @Column({ nullable: true })
  photoUrl: string;

  @Column({ type: 'decimal', precision: 2, scale: 1, default: 0 })
  rating: number;

  @Column({ default: 0 })
  reviewCount: number;

  @Column({ type: 'text', array: true, default: '{}' })
  specialties: string[];

  @Column({ nullable: true })
  tier: string;

  @Column({ default: true })
  isAvailable: boolean;

  @Column({ type: 'timestamptz', nullable: true })
  nextAvailableAt: Date;

  @Column({ type: 'timestamptz', nullable: true })
  deletedAt: Date;
}
